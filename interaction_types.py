import os
import sys
import math
from pymol import cmd

def distance(a1, a2):
    return math.sqrt(sum((a1.coord[i] - a2.coord[i])**2 for i in range(3)))

def classify_interaction(a1, a2, dist):
    donors = ['N', 'NE', 'NH1', 'NH2', 'ND1']
    acceptors = ['O', 'OD1', 'OD2', 'OE1', 'OE2']
    pos_res = ['ARG', 'LYS', 'HIS']
    neg_res = ['ASP', 'GLU']

    if a1.name in donors and a2.name in acceptors and dist <= 3.5:
        return 'H-bond'
    if (a1.resn in pos_res and a2.resn in neg_res or
        a1.resn in neg_res and a2.resn in pos_res) and dist <= 4.0:
        return 'Ionic'
    if dist <= 4.5:
        return 'VdW'
    return None

def get_chain_residue_indices(atoms):
    """Map (resn, resi) → relative index per chain."""
    seen = set()
    index_map = {}
    idx = 1
    for a in atoms:
        key = (a.resn, a.resi)
        if key not in seen:
            index_map[key] = idx
            seen.add(key)
            idx += 1
    return index_map

def process_structure(pdb_file, chain1='H', chain2='T', outdir='interaction_table'):
    obj = os.path.basename(pdb_file).replace(".pdb", "")
    cmd.load(pdb_file, obj)

    atoms1 = cmd.get_model(f"{obj} and chain {chain1} and polymer").atom
    atoms2 = cmd.get_model(f"{obj} and chain {chain2} and polymer").atom

    residx1 = get_chain_residue_indices(atoms1)
    residx2 = get_chain_residue_indices(atoms2)

    interactions = set()

    for a1 in atoms1:
        for a2 in atoms2:
            d = distance(a1, a2)
            label = classify_interaction(a1, a2, d)
            if label:
                h_key = (a1.resn, a1.resi)
                t_key = (a2.resn, a2.resi)
                h_rel = residx1.get(h_key, '?')
                t_rel = residx2.get(t_key, '?')
                h_res = f"{a1.resn} {h_rel} ({a1.resi})"
                t_res = f"{a2.resn} {t_rel} ({a2.resi})"
                interactions.add((h_res, t_res, label))

    os.makedirs(outdir, exist_ok=True)
    out_path = os.path.join(outdir, f"{obj}_interactions.tsv")

    with open(out_path, "w") as f:
        f.write("Chain_H_Res\tChain_T_Res\tInteraction_Type\n")
        for h, t, label in sorted(interactions, key=lambda x: (int(x[1].split()[1]), x[0])):
            f.write(f"{h}\t{t}\t{label}\n")

    print(f"✔ Table saved: {out_path}")
    cmd.delete("all")

def batch_process(pdb_dir):
    pdbs = [os.path.join(pdb_dir, f) for f in os.listdir(pdb_dir) if f.endswith(".pdb")]
    if not pdbs:
        print(f"⚠ No .pdb files found in {pdb_dir}")
        return
    for pdb in pdbs:
        process_structure(pdb)

# Run when pymol -cq is used
pdb_dir = sys.argv[1] if len(sys.argv) > 1 else "."
print(f">> Running interaction analysis in: {pdb_dir}")
batch_process(pdb_dir)
