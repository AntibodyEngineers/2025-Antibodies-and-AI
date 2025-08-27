batch_rfa.sh
```
#!/bin/bash

# V120 L15
# poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
#     --config-name antibody \
#     antibody.target_pdb=8sfs-T.pdb \
#     antibody.framework_pdb=8sfs-H.pdb \
#     inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
#     'ppi.hotspot_res=[T120,T15]' \
#     'antibody.design_loops=[H1:,H2:,H3:]' \
#     inference.num_designs=20 \
#     inference.output_prefix=out_v120_l15/8sfs_

#######################################

mkdir out_l15_i188
# L15 I188
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-T.pdb \
    antibody.framework_pdb=8sfs-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T15,T188]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=20 \
    diffuser.T=50 \
    inference.output_prefix=out_l15_i188/8sfs_

# V120 L15 R122 K113 I188


#######################################

mkdir out_v120_r122
# V120 R122
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-T.pdb \
    antibody.framework_pdb=8sfs-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T120,T122]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=20 \
    inference.output_prefix=out_v120_r122/8sfs_
```
