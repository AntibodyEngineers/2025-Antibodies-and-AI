# PyMol
The [PyMol](https://pymol.org) viewer is popular in many structural biology groups. An advantage of PyMol is that it is scriptable and the user interface provides a rich command line experience. PyMol offers several hundred commands, with programming syntax, to create detailed molecular displays and images. Its primary disadvantages are poor sequence display and manipulation capabilities, lack of integration with public databases, and limitations adding meta data, like FPOP values to structures.  

PyMol runs as local program on personal computers and is available in licensed and open-source versions.

## Installing OS PyMol
Mac OS, used homebrew. Followd the instructions @ (https://formulae.brew.sh/formula/pymol), updated via brew upgrate pymol. 

## PyMol commands
Selections – create named objects that can be displayed in differential ways.  
>select 3WD5_A_7-31, chain A & resi 7-31 
Will select the atoms for residues starting with 7 and ending with 31 in chain A, & can be replaced with “and”.  
Color and Show are used to set colors and display types (lines, sticks, spheres, surfaces, …)  
Custom colors need to first be set   
>set_color mycol1, [1.00, 0.00, 0.00]   
>set_color mycol1, [255, 0.00, 0.00]  
Either one sets mycol1 to red.  
The color and show syntax are of the form command setting, selection. Selection can be a previously named selection. For example  
>color gray, chain A  
Will color chain A gray.   
>color mycol1, chain A  
Will color chain A with the mycol1 custom color  
>color mycol1, 3WD5_A_7-31  
Will color named selection 3WD5_A_7-31 with the mycol1 custom color  
Show styles work in a similar way.

---

## PyMol scripts
PyMol commands can be added to a text file like iCn3D commands or embedded in Python scripts.  

### Command scripts
Command script files should have a “.pml” extension. This is needed to open the script file with PyMol from a command line. 
>pymol myscript.pml  
>pymol -r myscript.pml

### Examples
Lots of great examples on the internet 
1. https://www.blopig.com/blog/2013/07/making-protein-protein-interfaces-look-decently-good/
2. https://www.pymolwiki.org/index.php/Gallery
3. From ChatGPT
```python
# Load your structure (replace with your file path)
load your_structure.pdb

# Select chains H and T
select chainH, chain H
select chainT, chain T

# Show cartoon for clarity
hide everything
show cartoon, chainH or chainT
color cyan, chainH
color orange, chainT

# Show side chains for interaction context
show sticks, (chainH or chainT) and sidechain
util.cbaw

# Define close contacts between chainH and chainT (distance < 4.0 Å)
select close_contacts, (chainH within 4.0 of chainT) and not (chainH within 2.0 of chainT)

# Optional: highlight involved residues
select interacting_residues_H, byres (chainH within 4.0 of chainT)
select interacting_residues_T, byres (chainT within 4.0 of chainH)
color green, interacting_residues_H
color magenta, interacting_residues_T

# Draw distance lines between atoms < 4.0 Å apart from H to T
dist interactions, chainH, chainT, 4.0

# Zoom on interaction site
zoom close_contacts
```
in PyMol
```
@visualize_HT_interactions.pml
```
Find H-bonds
```
find_pairs hbond, chainH, chainT
```


