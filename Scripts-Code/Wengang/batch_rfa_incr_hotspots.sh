#!/bin/bash

# V120 L15
# poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
#     --config-name antibody \
#     antibody.target_pdb=8sfs-prep-T.pdb \
#     antibody.framework_pdb=8sfs-prep-H.pdb \
#     inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
#     'ppi.hotspot_res=[T120,T15]' \
#     'antibody.design_loops=[H1:,H2:,H3:]' \
#     inference.num_designs=20 \
#     inference.output_prefix=out200_v120_l15/8sfs_

#######################################

mkdir out200_r122_k113
# L15 I188
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T122,T113]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    diffuser.T=50 \
    inference.output_prefix=out200_r122_k113/8sfs_

#  R122 K113 R109 I188 L15 V120 # F114


#######################################


mkdir out200_r122_k113_r109
# V120 R122
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T122,T113,T109]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    inference.output_prefix=out200_r122_k113_r109/8sfs_


#  R122 K113 R109 I188 L15 V120 # F114

#######################################

mkdir out200_r122_k113_r109_i188
# V120 R122
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T122,T113,T109,T188]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    inference.output_prefix=out200_r122_k113_r109_i188/8sfs_


#  R122 K113 R109 I188 L15 V120 # F114

#######################################

mkdir out200_r122_k113_r109_i188_l15
# V120 R122
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T122,T113,T109,T188,T15]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    inference.output_prefix=out200_r122_k113_r109_i188_l15/8sfs_


#  R122 K113 R109 I188 L15 V120 # F114

#######################################

mkdir out200_r122_k113_r109_i188_l15_v120
# V120 R122
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T122,T113,T109,T188,T15,T120]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    inference.output_prefix=out200_r122_k113_r109_i188_l15_v120/8sfs_


#  R122 K113 R109 I188 L15 V120 # F114

#######################################

mkdir out200_r122_k113_r109_i188_l15_v120
# V120 R122
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T122,T113,T109,T188,T15,T120]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    inference.output_prefix=out200_r122_k113_r109_i188_l15_v120/8sfs_


#  R122 K113 R109 I188 L15 V120 # F114

#######################################

mkdir out200_i188_l15
# L15 I188
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T188,T15]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    diffuser.T=50 \
    inference.output_prefix=out200_i188_l15/8sfs_

#  R122 K113 R109 I188 L15 V120 # F114


#######################################

mkdir out200_i188_l15_v120
# L15 I188
poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-prep-T.pdb \
    antibody.framework_pdb=8sfs-prep-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T188,T15,T120]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=200 \
    diffuser.T=50 \
    inference.output_prefix=out200_i188_l15_v120/8sfs_

#  R122 K113 R109 I188 L15 V120 # F114


