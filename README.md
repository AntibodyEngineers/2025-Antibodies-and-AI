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
