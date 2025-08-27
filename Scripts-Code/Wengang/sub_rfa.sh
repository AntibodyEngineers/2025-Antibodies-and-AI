#!/bin/bash
#SBATCH --job-name=rfa_sfs
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=gpu
#SBATCH --gres=gpu:a100:1
#SBATCH --ntasks=4
#SBATCH --ntasks-per-core=1
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=1
#SBATCH --mem=19g

#SBATCH --time=30:00:00
#
module add singularity

. /usr/local/current/singularity/app_conf/sing_binds
singularity shell --nv -B .:/home /data/zhangw21/RFantibody/rfantibody_redo.sif

singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif poetry run pip install biotite
singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif cd /home


singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif mkdir /data/zhangw21/RFantibody/antibody_hackathon_aug_2025/fp_nanobodies/Unique_Mechanisms/8sfs/out_v120_l15
# V120 L15
singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-T.pdb \
    antibody.framework_pdb=8sfs-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T120,T15]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=20 \
    inference.output_prefix=out_v120_l15/8sfs_

#######################################

singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif mkdir /data/zhangw21/RFantibody/antibody_hackathon_aug_2025/fp_nanobodies/Unique_Mechanisms/8sfs/out_l15_i188
# L15 I188
singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-T.pdb \
    antibody.framework_pdb=8sfs-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T15,T188]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=20 \
    inference.output_prefix=out_l15_i188/8sfs_

# V120 L15 R122 K113 I188


#######################################

singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif mkdir /data/zhangw21/RFantibody/antibody_hackathon_aug_2025/fp_nanobodies/Unique_Mechanisms/8sfs/out_v120_r122
# V120 R122
singularity exec /data/zhangw21/RFantibody/rfantibody_redo.sif poetry run python  /home/src/rfantibody/rfdiffusion/rfdiffusion_inference.py \
    --config-name antibody \
    antibody.target_pdb=8sfs-T.pdb \
    antibody.framework_pdb=8sfs-H.pdb \
    inference.ckpt_override_path=/home/weights/RFdiffusion_Ab.pt \
    'ppi.hotspot_res=[T120,T122]' \
    'antibody.design_loops=[H1:,H2:,H3:]' \
    inference.num_designs=20 \
    inference.output_prefix=out_v120_r122/8sfs_



