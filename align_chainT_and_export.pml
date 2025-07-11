import os
import glob

# Set your input and output directory
input_dir = "path/to/your/structures"
output_dir = "aligned_structures"

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Find all .pdb files
pdb_files = sorted(glob.glob(os.path.join(input_dir, "*.pdb")))
if not pdb_files:
    print("No PDB files found.")
    quit()

# Load the first structure as reference
ref_file = pdb_files[0]
ref_name = os.path.splitext(os.path.basename(ref_file))[0]
load ref_file, ref_name
select ref_chain, f"{ref_name} and chain T"

# Process each PDB
for pdb_file in pdb_files:
    obj_name = os.path.splitext(os.path.basename(pdb_file))[0]
    if obj_name == ref_name:
        continue  # skip reference, already loaded

    load pdb_file, obj_name
    select target_chain, f"{obj_name} and chain T"
    
    # Align chain T of current structure to chain T of reference
    align target_chain, ref_chain

    # Save aligned structure with header preserved
    out_file = os.path.join(output_dir, f"{obj_name}.pdb")
    save out_file, obj_name

# Save the aligned reference structure as well
save os.path.join(output_dir, f"{ref_name}.pdb"), ref_name

print("All structures aligned and saved.")
