# PyMol
The [PyMol](https://pymol.org) viewer is popular in many structural biology groups. An advantage of PyMol is that it is scriptable and the user interface provides a rich command line experience. PyMol offers several hundred commands, with programming syntax, to create detailed molecular displays and images. Its primary disadvantages are poor sequence display and manipulation capabilities, lack of integration with public databases, and limitations adding meta data, like FPOP values to structures.  

PyMol runs as local program on personal computers and is available in licensed and open-source versions.

## Installing
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
