# 2025-Antibodies-and-AI
Updates and new projects in the Antibody Engineering Hackahons

#RFAntibody
work will use Rosetta Commons RFAntibody  
Followed the instructions  
Needed a new gpu instance - test-gpu, will rename later - antibodies-gpu, created last year, broke. The instance as not connecting to its GPUs. Tested by making a new one (Ubuntu22, tried Ubuntu24, but got lots of errors on initialization), installing torch and testing:
```
python3 -m pip install torch
python3
>>> import torch; print(torch.cuda.is_available(), torch.cuda.get_device_name(0) if torch.cuda.is_available() else "No GPU")
```
On antibodies-gpu - False  
On test-gpu - True NVIDIA A100-SXM4-40GB

## RFAntibody issues
The installation mostly works needed to:
```
cp /home/scripts/rfdiffusion_inference.py /home/src/rfantibody/rfdiffusion/
```
To get this scipt in the right place for later
```
poetry run pip install biotite
```
Then 
```
poetry run python /home/scripts/util/chothia2HLT.py scripts/examples/example_inputs/hu-4D5-8_Fv.pdb --heavy H --light L --target T --output myHLT.pdb
```
Works  
For 
```
poetry run python  /home/src/rfantibody/scripts/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=/home/scripts/examples/example_inputs/rsv_site3.pdb \
    antibody.framework_pdb=/home/scripts/examples/example_inputs/hu-4D5-8_Fv.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T305,T456]' \
    'antibody.design_loops=[L1:8-13,L2:7,L3:9-11,H1:7,H2:6,H3:5-13]' \
    inference.num_designs=20 \
    inference.output_prefix=/home/scripts/examples/example_outputs/ab_des
```
The first line needs to be 
```
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py
```
And this 
```
bash /home/scripts/examples/rfdiffusion/antibody_pdbdesign.sh
```
is just the above command. So if run this way edit the path  
Also, nasty - saving the docker image to a tar file does not save the whole state - deleting the image and staring again means rerunning bash /home/include/setup.sh and poetry run pip install biotite  
And for this: 
```
/home/scripts/examples/rf2/ab_pdb_example.sh
```
Edit /home/src/rfantibody/rf2/config/base.yaml to replace /home/weights/RFab_overall_best.pt with /home/weights/RF2_ab.pt  

To have a clean starting image - delete existing images, reinstall, run the install commands (+ less, below), edit the ab_pdb_example.sh, and, then save the image. 

## Misc
Anything you like to use needs to be in the container. I like less. 
```
apt-get install less
```

## Docker
Success, worked though the examples - preserve the work
```
exit # exit/stop the docker image
docker commit rfantibody rfantibody:latest
docker save -o rfantibody.tar rfantibody:latest
docker load -i rfantibody.tar
docker images # show all images
docker start -ai rfantiboty # start / enter the container
# Other useful commands
docker start rfantibody # just start
docker exec -it rfantibody /bin/bash # enter
docker ps # list running containers
docker run --name rfantibody --gpus all -v .:/home --memory 10g -it rfantibody # launch a new container, called rfantibody, from the rfantibody image 
```

