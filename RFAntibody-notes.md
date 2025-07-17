# RFAntibody Notes
Part of the 2025 Hackathon AI work will focuse on using the Rosetta Commons RFAntibody. It run in a docker image and requires a GPU. GPU testing, installation, testing notes, and docker commands are described below. 

## GPU
RFAntibody requires a GPU. Started with last year's instance, but determined it was not connecing to the Jetstream GPUs, so a new instance was created.  
Tested by making a new one (Ubuntu22 [tried Ubuntu24, but got lots of errors on initialization]).  
To test: install torch and in the phython3 command env run:
```
python3 -m pip install torch
python3
>>> import torch; print(torch.cuda.is_available(), torch.cuda.get_device_name(0) if torch.cuda.is_available() else "No GPU")
```
On antibodies-gpu, False was returned  
On test-gpu, True NVIDIA A100-SXM4-40GB was returned
Both antibodies-gpu and test-gpu returnded a positive status with:
```
nvidia-smi
```

## RFAntibody Installation
Summary of steps:
1. Install RFAntibody
   ```
   git clone https://github.com/RosettaCommons/RFantibody.git
   ```
3. Run download_weights
   ```
   bash include/download_weights.sh
   ```
5. Sudo usermod
   ```
   sudo usermod -aG docker $USER
   ```
7. Exit terminal, relogin,
8. cd to RFAntibody
9. Build docker image
   ```
   docker build -t rfantibody .
   ``` 
10. Start the docker image
    ```
    docker run --name rfantibody --gpus all -v .:/home --memory 10g -it rfantibody
    ```
11. Setup Pyton Env
    ```
    bash /home/include/setup.sh
    ```
12. Install biotite
    ```
    poetry run pip install biotite
    ```
13. Copy rfdiffusion_inference to src dir
    ```
    cp /home/scripts/rfdiffusion_inference.py /home/src/rfantibody/rfdiffusion/
    ```
14. Test chothia2HLT.py
    ```
    poetry run python /home/scripts/util/chothia2HLT.py scripts/examples/example_inputs/hu-4D5- 8_Fv.pdb --heavy H --light L --target T --output myHLT.pdb
    ```
15. Test RFdiffusion
    adjust - the first line (see item 4 below)
16. Test ProteinMPNN
    ```
    bash /home/scripts/examples/proteinmpnn/ab_pdb_example.sh
    ```
17. Fix /home/src/rfantibody/rf2/config/base.yaml (see item 5 below)
18. Test RF2
    ```
    bash /home/scripts/examples/rf2/ab_pdb_example.sh
    ```
    <hr>
    
### Details / Notes   
The installation mostly works needed to:
1. Install biotite
```
poetry run pip install biotite
```
2. Copy rfdiffusion_inference.py to a source directory, which is called by other scripts
```
cp /home/scripts/rfdiffusion_inference.py /home/src/rfantibody/rfdiffusion/
```
3. The example "# From inside of the rfantibody container, poetry run python /home/scripts/util/chothia_to_HLT.py -inpdb mychothia.pdb -outpdb myHLT.pdb is incorrect the correct usage is:
```
poetry run python /home/scripts/util/chothia2HLT.py scripts/examples/example_inputs/hu-4D5-8_Fv.pdb --heavy H --light L --target T --output myHLT.pdb
```
4. The example command below is also incorrect.  
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
is just the above command. So if run this way edit the path.

5. The script, /home/scripts/examples/rf2/ab_pdb_example.sh calls a yaml file that uses a non-exstant weights file.  
> Edit /home/src/rfantibody/rf2/config/base.yaml  
> Replace /home/weights/RFab_overall_best.pt with /home/weights/RF2_ab.pt  
 
6. Anything you like to use needs to be in the container. I like less instead of more. 
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
