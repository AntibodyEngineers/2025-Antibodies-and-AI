# RFAntibody Notes

Part of the 2025 Hackathon AI work will **focus** on using the Rosetta Commons **RFAntibody**.  
RFAntibody runs in a Docker image and **requires a GPU**. [GPU testing](#gpu) and [Docker commands](#docker) are described below.

---

## RFAntibody Installation

### Summary of steps

1. **Install RFAntibody**
```bash
git clone https://github.com/RosettaCommons/RFantibody.git
```

2. **Run download_weights**
```bash
bash include/download_weights.sh
```

3. **Add user to Docker group**
```bash
sudo usermod -aG docker $USER
```

4. **Exit terminal & re-login**

5. **Change directory to RFAntibody**
```bash
cd RFAntibody
```

6. **Build Docker image**
```bash
docker build -t rfantibody .
```
With a multiuser system images and containers should specify the users image and container.
```bash
docker build -t rfantibody_username .
```
    
8. **Start the Docker image**
```bash
docker run --name rfantibody --gpus all -v .:/home --memory 10g -it rfantibody
```
With user specification
```bash
docker run --name rfantibody_username --gpus all -v .:/home --memory 10g -it          rfantibody_username
```

10. **Set up the Python environment**
```bash
bash /home/include/setup.sh
```

11. **Install Biotite**
> [!IMPORTANT]
> Not included in the RFAntibody instructions
```bash
poetry run pip install biotite
```
> [!TIP]
> Optional: inside the container, install `less` (instead of `more`)  
> any other software must be installed in the container as well
```bash
apt-get update && apt-get install -y less
```
  
11. **Copy `rfdiffusion_inference.py` to the source directory**
> [!IMPORTANT]
> Found in the RFAntibody issues  
```bash
cp /home/scripts/rfdiffusion_inference.py /home/src/rfantibody/rfdiffusion/
```

13. **Test `chothia2HLT.py`**
> [!IMPORTANT]
> RFAntibody instructions were incorrect  

```bash
poetry run python /home/scripts/util/chothia2HLT.py \
  scripts/examples/example_inputs/hu-4D5-8_Fv.pdb \
  --heavy H --light L --target T --output myHLT.pdb
```

15. **Test RFdiffusion adjust – the first line (see item 4 below)**

16. **Test ProteinMPNN**
```bash
bash /home/scripts/examples/proteinmpnn/ab_pdb_example.sh
```

17. **Fix `/home/src/rfantibody/rf2/config/base.yaml` (see script fixes)**
> [!IMPORTANT]
> RFAntibody base.yaml specifies a **non‑existent** weights file.

18. **Test RF2**
```bash
bash /home/scripts/examples/rf2/ab_pdb_example.sh
```
---
## Details / Notes

The installation mostly worked but required:

- **Biotite**
  ```bash
  poetry run pip install biotite
  ```

- **Copy `rfdiffusion_inference.py`** to a source directory (called by other scripts):
  ```bash
  cp /home/scripts/rfdiffusion_inference.py /home/src/rfantibody/rfdiffusion/
  ```

- The example below is **incorrect**:
  ```bash
  # From inside the rfantibody container:
  poetry run python /home/scripts/util/chothia_to_HLT.py -inpdb mychothia.pdb -outpdb myHLT.pdb
  ```
  Correct usage:
  ```bash
  poetry run python /home/scripts/util/chothia2HLT.py \
    scripts/examples/example_inputs/hu-4D5-8_Fv.pdb \
    --heavy H --light L --target T --output myHLT.pdb
  ```

- Another incorrect example:
  ```bash
  poetry run python /home/src/rfantibody/scripts/rfdiffusion_inference.py \
      --config-name antibody \
      antibody.target_pdb=/home/scripts/examples/example_inputs/rsv_site3.pdb \
      antibody.framework_pdb=/home/scripts/examples/example_inputs/hu-4D5-8_Fv.pdb \
      inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
      'ppi.hotspot_res=[T305,T456]' \
      'antibody.design_loops=[L1:8-13,L2:7,L3:9-11,H1:7,H2:6,H3:5-13]' \
      inference.num_designs=20 \
      inference.output_prefix=/home/scripts/examples/example_outputs/ab_des
  ```

  **First line must be:**
  ```bash
  poetry run python /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py
  ```

- Script fixes:
  ```bash
  bash /home/scripts/examples/rfdiffusion/antibody_pdbdesign.sh
  ```
  is just the command above; adjust the path if you run it.

- `/home/scripts/examples/rf2/ab_pdb_example.sh` points to a **non‑existent** weights file.  
  Edit `/home/src/rfantibody/rf2/config/base.yaml` and replace:

  ```
  /home/weights/RFab_overall_best.pt
  ```
  with
  ```
  /home/weights/RF2_ab.pt
  ```

---

## Docker
The commands below assume RFAntibody and rfantibody are the folder and image names, respectively. 

Worked through the examples; to **preserve** the work:

```bash
exit                               # exit/stop the Docker container
docker commit rfantibody rfantibody:latest
docker save -o rfantibody.tar rfantibody:latest
docker load -i rfantibody.tar
docker images                      # show all images
docker start -ai rfantibody        # start + attach
```

**Other useful commands**

```bash
docker start rfantibody
docker exec -it rfantibody /bin/bash
docker ps
docker run --name rfantibody --gpus all -v .:/home --memory 10g -it rfantibody
```

**Cleaning up images and containers**

Docker ps and docker image list running containers and images, respectively.  
To remove a container
```bash
docker rm name|container_id
docker image rm name|image_id
```

---

## GPU

RFAntibody **requires** a GPU.

- Last year’s instance showed `nvidia-smi`, but was **not connecting** to Jetstream GPUs.  
- Tested a fresh Ubuntu 22 instance (Ubuntu 24 produced many init errors).

**To test CUDA availability**

```bash
python3 -m pip install torch
python3
>>> import torch
>>> print(\
torch.cuda.is_available(),\
torch.cuda.get_device_name(0) if torch.cuda.is_available() else "No GPU"\
)
```
Alternatively, with torch (and numpy) installed
```bash
python3 -c "import torch; print(torch.cuda.is_available(), torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'No GPU')"
```

Results from antibodies-gpu and test-gpu
| Host            | torch.cuda.is_available | Device Name               |
|-----------------|------------------------|---------------------------|
| antibodies-gpu  | False                  | —                         |
| test-gpu        | True                   | NVIDIA A100‑SXM4‑40GB     |

Both hosts reported healthy GPUs with `nvidia-smi`, but only **test‑gpu** was usable by PyTorch.

---
