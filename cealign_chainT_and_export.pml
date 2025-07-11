import os
import glob

input_dir = "path/to/your/pdbs"         # ← Change this to your directory
output_dir = "aligned_structures"
os.makedirs(output_dir, exist_ok=True)

# Find all .pdb files
pdb_files = sorted(glob.glob(os.path.join(input_dir, "*.pdb")))
if not pdb_files:
    print("No PDB files found.")
    quit()

# Load reference structure
ref_file = pdb_files[0]
ref_name = os.path.splitext(os.path.basename(ref_file))[0]
load(ref_file, ref_name)

# Select reference chain T
ref_chain = f"{ref_name} and chain T"

# Align and save each other structure
for pdb_file in pdb_files[1:]:
    name = os.path.splitext(os.path.basename(pdb_file))[0]
    load(pdb_file, name)
    
    target_chain = f"{name} and chain T"
    if count_atoms(target_chain) == 0:
        print(f"WARNING: {name} does not contain chain T")
        continue

    # Perform cealign chain T → T
    try:
        cealign(ref_chain, target_chain)
        print(f"Aligned {name} to {ref_name}")
    except Exception as e:
        print(f"ERROR aligning {name}: {e}")
        continue

    save(os.path.join(output_dir, f"{name}.pdb"), name)

# Save reference as well
save(os.path.join(output_dir, f"{ref_name}.pdb"), ref_name)

print("All structures aligned and saved to", output_dir)
