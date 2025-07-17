# iCn3D
[iCn3d](https://www.ncbi.nlm.nih.gov/Structure/icn3d/), developed and supported by [NCBI](https://www.ncbi.nlm.nih.gov/)(The National Center for Biotechnology Information) is a web-based system that is used to visualize structures and their sequence data. iCn3D has many advanced features, such as getting interaction data for structures, that can be used to evaluate the the designs created by RFAntibody. It can be run as a web application from the NCBI server using data imported from a [collection](#collections) or on desktop computers with code obtained from the [iCn3D GitHub repository](https://github.com/ncbi/icn3d).

## Web version

## Localized version
iCn3D can also be run on local computers. The code can be optained by running:
```bash
git clone https://github.com/ncbi/icn3d.git
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
Web Root
  /icn3d (former dist)
  /pdb, collection files
  /other files
```
---
### Runing localy


## Node scripts

## Python scripts

## Collections

## iCn3D
Installing - follow the build instructions, firt step (review) many not be necessary, deprecated stuff  
After gulp the working icn3d will be in the dist directory (not documented), that can be moved and renamed to icn3d for localhost:8000/icn3d  
Node scripts, Jiyao made a new release to fix an issue - install the components in the direcory where stuff will be run  
Copy js scripts to this location

