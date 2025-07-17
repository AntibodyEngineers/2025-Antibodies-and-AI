# iCn3D
[iCn3d](https://www.ncbi.nlm.nih.gov/Structure/icn3d/), developed and supported by [NCBI](https://www.ncbi.nlm.nih.gov/)(The National Center for Biotechnology Information) is a web-based system that is used to visualize structures and their sequence data. iCn3D has many advanced features, such as getting interaction data for structures, that can be used to evaluate the the designs created by RFAntibody. It can be run as a web application from the NCBI server using data imported from a [collection](#collections) or on desktop computers with code obtained from the [iCn3D GitHub repository](https://github.com/ncbi/icn3d).

## Web version
The web version is the "standard" way to run iCn3D. It hass all the features and can import files from NCBI servers as well as upload local files including collection files. Local iCn3D is needed for scripting application and processing data via node.js or python scripts as described below. 

## Collections
Collections (developed by Digital World Biology) are a way to import and interact with annotated sets of molecular structures in iCn3D. iCn3D support three kinds of collections:
1. A list of PDB IDs in a json file
2. A zip compressed directory of gz compressed pdb file
3. A zip compressed directory of pdb files listed in a json file
Additionally, a single pdb, or pdb.gz file can be uploaded and added to a collection.
Collection json files specify a "collectionTitle", "collectionDescription", and a list of "structures". Each structure includes:
- an id: header-name.pdb, or datbase id
- a titile: text
- a 

## Localized version
iCn3D can also be run on local computers. The code can be optained by running:
```bash
git clone https://github.com/ncbi/icn3d.git
```
Then
```
cd icn3d
```
### Installing
The current instructions in the iCn3D GitHub page are out of date (npm config set -g production false is deprecated, and delete package-lock.json is assumed to be rm packag-lock.json) The following build commands work:
```bash
rm package-lock.json
npm install
npm install -g gulp
npm install uglify-js@3.3.9
gulp
cd dist
open full.html
```
The last two steps are to test for a successful build. The working local version of icn3d is in the dist directory. This directory can be renamed (icn3d) and moved around. When scripting icn3d it needs to be at the root level. 
```
web_root (any dirname)
  /icn3d (former dist)
  /pdb, collection files
  /other files
```
---
### Running localy
Within the web_root directory iCn3D can be launched in one of three ways:
1. MacOS   - open icn3d/full.html
2. python  - python3 -m http.server | python3 -m webbrowser 'http://localhost:8000/icn3d/?type=pdb&url=/path_to_file.pdb'
3. node.js - http-server -a localhost -o '/icn3d/?type=pdb&url=/path_to_file.pdb'

Caveats:
>node.js does not require http as it is 'http://localhost:8080', a system default port.  
>type=collection does not work at this time. 

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
Note this follows the [icn3dnode documentation](https://github.com/ncbi/icn3d/blob/master/icn3dnode/README.md) with the addition of installing three. When first run, scripts complained that it was not installed. 

To run a script, in the icn3d directory:
```
node icn3dnode/interactiondetail2.js path_to_file.pdb H T
```
For example 
```
node icn3dnode/interactiondetail2.js ../RFantibody/gfp_rf2/nb_gfp_des_0_dldesign_0_best.pdb H T
```
Prints the interactions in json format
Example scripts and their descriptions can be found in the [icn3dnode/README.md](https://github.com/ncbi/icn3d/blob/master/icn3dnode/README.md). 

## Python scripts
iCn3D can also be scripted in python. This is work in progress. A draft script was developed and mostly works, but the interactions are intramolecular for the first chain listed. To get started, selenium and webdriver are needed. Chrome was a pain, so, used Firefox with the geckodriver (on MacOS):
```
pip install selenium
pip install selenium webdriver-manager
brew install geckodriver
```
Brew install can be skipped if geckodriver is already in PATH — webdriver-manager can handle it too (ChatGPT).
The example, [RFAb_Interaction.py](/TMS-scripts/RFAb_Interaction.py) script can be found in the [TMS-scripts](/TMS-scripts) folder. 



