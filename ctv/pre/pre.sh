#!/bin/bash
#SBATCH --job-name pre_ctv
#SBATCH -o salida_pre_ctv
#SBATCH -N1 --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-socket=1
#SBATCH --time=2:00:00
#SBATCH --gres=gpu:1
#SBATCH --account=AIRC_Fortun21
#SBATCH --partition=m100_all_serial

module load profile/lifesc
module load autoload amber/2020
#export CUDA_VISIBLE_DEVICES="0"

cd $SLURM_SUBMIT_DIR

./ph_conts_AmberMdPrep.sh -p ../top/ctv.prmtop -c ../top/ctv.rst7 --temp 300 --skipfinaleq
