#!/usr/bin/env python3

import os
import argparse
from Bio.PDB import PDBParser, Superimposer, PDBIO, Select
from Bio.PDB.vectors import Vector

class PreserveAllAtoms(Select):
    def accept_atom(self, atom):
        return True  # Keep all atoms in output

def get_chain_atoms(chain, atom_names=("N", "CA", "C")):
    atoms = []
    for res in chain:
        for atom_name in atom_names:
            if atom_name in res:
                atoms.append(res[atom_name])
    return atoms


def parse_args():
    parser = argparse.ArgumentParser(description="Align PDB files using chain T and apply to all atoms.")
    parser.add_argument("reference", help="Reference PDB file (with chain T)")
    parser.add_argument("targets", nargs="+", help="PDB files to align")
    parser.add_argument("--outdir", default=".", help="Output directory (default: current)")
    return parser.parse_args()

def split_metadata(filepath):
    """Split lines into: pre-ATOM metadata, ATOM section (only ATOM/HETATM), post-ATOM metadata (TER + SCORE/REMARK/etc)"""
    pre_atom = []
    atom_block = []
    post_atom = []
    atom_seen = False
    in_atom_block = False

    with open(filepath) as f:
        for line in f:
            if line.startswith(("ATOM", "HETATM")):
                atom_seen = True
                in_atom_block = True
                atom_block.append(line)
            elif in_atom_block:
                # anything after ATOMs (including TER) is post-ATOM metadata
                in_atom_block = False
                post_atom.append(line)
            elif not atom_seen:
                pre_atom.append(line)
            else:
                post_atom.append(line)

    return pre_atom, atom_block, post_atom

def align_and_write(ref_file, target_files, outdir):
    parser = PDBParser(QUIET=True)
    ref_struct = parser.get_structure("ref", ref_file)
    ref_chain = ref_struct[0]["T"]
    ref_atoms = get_chain_atoms(ref_chain)

    for pdb_file in target_files:
        if pdb_file == ref_file:
            continue

        struct = parser.get_structure("model", pdb_file)
        model = struct[0]

        try:
            chain = model["T"]
        except KeyError:
            print(f"[!] Chain T not found in {pdb_file}, skipping.")
            continue

        target_atoms = get_chain_atoms(chain)
        print(f"[i] Target backbone atoms in {pdb_file}: {len(target_atoms)}")
        if len(ref_atoms) != len(target_atoms):
            print(f"[!] CA count mismatch in {pdb_file}, skipping.")
            continue

        sup = Superimposer()
        sup.set_atoms(ref_atoms, target_atoms)
        print(f"[INFO] RMSD for {pdb_file}: {sup.rms:.3f} Å")

        original_coords = [atom.coord.copy() for atom in model.get_atoms()]

        sup.apply(model.get_atoms())  # Apply transform to ALL atoms

        # Optional: Debug check for a few atoms before vs after
        print("[DEBUG] First few atoms from chain T after transform:")
        for i, atom in enumerate(chain.get_atoms()):
            if i >= 3:
                break
            print(f"  {atom.get_full_id()[3]}: {atom.get_name()} {atom.coord}")

        for i, atom in enumerate(model.get_atoms()):
            if i >= 3:
                break
            before = original_coords[i]
            after = atom.coord
            print(f"[DEBUG] Atom {i} moved: {before} → {after}")

        # Split file into metadata and atom sections
        metadata_before, _, metadata_after = split_metadata(pdb_file)

        # Prepare output
        metadata_after = [line for line in metadata_after if not line.startswith(("TER", "END"))]
        base = os.path.basename(pdb_file)
        name = base.replace(".pdb", "_aligned.pdb")
        out_path = os.path.join(outdir, name)

        with open(out_path, "w") as out_f:
            out_f.writelines(metadata_before)  # HEADER, TITLE, REMARK, etc.

            io = PDBIO()
            io.set_structure(struct)
            io.save(out_f, select=PreserveAllAtoms())  # Writes ATOMs + TER + END

            out_f.writelines(metadata_after)  # Anything else after ATOMs (e.g., SCORES)


        print(f"[✓] Aligned: {pdb_file} → {out_path}")

def main():
    args = parse_args()
    os.makedirs(args.outdir, exist_ok=True)
    align_and_write(args.reference, args.targets, args.outdir)

if __name__ == "__main__":
    main()
