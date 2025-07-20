# iCn3D
[iCn3D](https://www.ncbi.nlm.nih.gov/Structure/icn3d/), developed and supported by [NCBI](https://www.ncbi.nlm.nih.gov/) (The National Center for Biotechnology Information), is a web-based application that is used to visualize molecular structures and their sequence data. iCn3D has many advanced features, such as getting inter- and intra-molecular interaction data for structures, that can be used to evaluate the designs created by RFAntibody. It can be run from the from the NCBI server or on desktop computers with code obtained from the [iCn3D GitHub repository](https://github.com/ncbi/icn3d). Muliple structures can be viewed simultaneously by importing pdb formatted files, or indivually and in combinations using [collections](#collections).

## Web version
The web version is the simplest and "standard" way to run iCn3D. It has all the features and can import files from NCBI servers as well as upload local files including collection files. Local iCn3D is needed for scripting applications and processing data via Node.js or Python scripts as described below. 

## Collections
Collections (developed by Digital World Biology) are a way to import and interact with annotated sets of molecular structures in iCn3D. iCn3D supports three kinds of collections:
1. A list of PDB IDs in a JSON file
2. A zip-compressed directory of gz-compressed PDB files
3. A zip-compressed directory of PDB files listed in a JSON file
   
Additionally, a single PDB or PDB.GZ file can be uploaded and added to a collection.

> [!NOTE]
> **pdb files in a collection must have a HEADER line with a basename that matches the unambiguous portion of the filename**  
> HEADER header-name 

Collection JSON files specify a `"collectionTitle"`, `"collectionDescription"`, and a list of `"structures"`. Each structure includes:
- an `id`: header name or database ID
- a `title`: text
- a `description`: text
- `commands`: comma-separated list of iCn3D commands
  
For example,this file:
```json
{
  "collectionTitle": "RF designs",
  "collectionDescription": "Designs from RFAntibody",
  "structures": [
    {
      "id": "nb_gfp_des_1_dldesign_0_best",
      "title": "Des 1",
      "description": "<p>first in list</p>",
      "commands": [
        "display interaction 3d | stru_H stru_T | hbonds,salt bridge,interactions,halogen,pi-cation,pi-stacking | false | threshold 3.8 6 4 3.8 6 5.5",
        "line graph interaction pairs | stru_H stru_T | hbonds,salt bridge,interactions,halogen,pi-cation,pi-stacking | false | threshold 3.8 6 4 3.8 6 5.5"
      ]
    },
    {
      "id": "nb_gfp_des_2_dldesign_0_best",
      "title": "Des 2",
      "description": "<p>first in list</p>",
      "commands": [
        "display interaction 3d | stru2_H stru2_T | hbonds,salt bridge,interactions,halogen,pi-cation,pi-stacking | false | threshold 3.8 6 4 3.8 6 5.5",
        "line graph interaction pairs | stru2_H stru2_T | hbonds,salt bridge,interactions,halogen,pi-cation,pi-stacking | false | threshold 3.8 6 4 3.8 6 5.5"
      ]
    }
  ]
}
```
Will load the structures with the respective HEADER lines: HEADER nb_gfp_des_1_dldesign_0_best, and HEADER nb_gfp_des_2_dldesign_0_best. The IDs will be listed in the Collection Viewer window. When an ID is clicked, the interactions between the H and T chains are slected and displayed (first command), along with an intercation graphic (second command) per the image below. 

![collection showing a selected structure and its interchain interactions](/images/icn3d-collection.png?raw=true)

> [!TIP]
> Fighting with tabs & spaces from a code editor? Paste into https://jsonformatter.org/ to reformat. The above json was a pain.

## Localized version
iCn3D can also be run on local computers. The code can be obtained by running:
```bash
git clone https://github.com/ncbi/icn3d.git
```
Followed by:
```
cd icn3d
```
### Installing / Compiling 
The current instructions in the iCn3D GitHub page are out of date (npm config set -g production false is deprecated, and delete package-lock.json is assumed to be rm package-lock.json) The following build commands work:
```bash
rm package-lock.json
npm install
npm install -g gulp
npm install uglify-js@3.3.9
gulp
cd dist
open full.html
```
The last two steps test for a successful build; icn3d should launch in a browser window. 

> [!NOTE]
> "open" is Mac OSX command.
> If rm package-json is done after npm install uglify-js@3.3.9, as indicated in the iCn3D instructions, gulp will not work, and npm install needs to be rerun. As a first step everyting works OK. 

> [!NOTE]
> The working local version of icn3d is in the "dist" directory. This directory can be renamed (icn3d) and moved around. When scripting, the icn3d directory needs to be at the root level of the directory it is in. 

An example directory may look like this.
```
web_root (any dirname)
   /icn3d (former dist)
   /pdb, collection files
   /other files
   /node_modules
   /package.json
   /package-lock.json
```
---
### Running localy
Within the web_root directory iCn3D can be launched in one of three ways:
1. MacOS   - open icn3d/full.html | open icn3d/index.html
2. python  - python3 -m http.server | python3 -m webbrowser 'http://localhost:8000/icn3d/?type=pdb&url=/path_to_file.pdb'
3. node.js - http-server -a localhost -o '/icn3d/?type=pdb&url=/path_to_file.pdb'

> [!TIP]
> 1. node.js does not require http as it is 'http://localhost:8080', a system default port.  
> 2. type=collection does not work at this time.
> 3. the above commands assume an index.html file is present, other html files can be specified. In those cases the url should include the file, e.g. '/icn3d/full.html?...'

## Node scripts
iCn3D ships with example node.js scripts that can be used to automate analyses such as determining the amino acid intercations between a paratope and epitope. To use a set of node modues must be installed in the orginal icn3d directory
```bash
npm install jquery
npm install jsdom
npm install icn3d
npm install axios
npm install querystring
npm install three
```
> [!NOTE]
> This follows the [icn3dnode documentation](https://github.com/ncbi/icn3d/blob/master/icn3dnode/README.md) with the addition of installing the js library three. When first run, scripts complained that "three" was not installed. 

To run a script, in the icn3d directory:
```
node icn3dnode/interactiondetail2.js path_to_file.pdb H T
```
For example: 
```
node icn3dnode/interactiondetail2.js ../RFantibody/gfp_rf2/nb_gfp_des_0_dldesign_0_best.pdb H T
```
Prints the interactions in json format  

Example scripts and their descriptions can be found in the [icn3dnode/README.md](https://github.com/ncbi/icn3d/blob/master/icn3dnode/README.md). 

## Python scripts
iCn3D can also be scripted in python. This is work in progress. A draft script was developed and mostly works, but the interactions are intramolecular for the first chain listed. 

To get started, selenium and webdriver are needed. Chrome was a pain, so, used Firefox with the geckodriver (on MacOS):
```
pip install selenium
pip install selenium webdriver-manager
brew install geckodriver
```
Brew install can be skipped if geckodriver is already in PATH — webdriver-manager can handle it too (ChatGPT).
The example, [RFAb_Interaction.py](/TMS-scripts/RFAb_Interaction.py) script can be found in the [TMS-scripts](/TMS-scripts) folder. 



