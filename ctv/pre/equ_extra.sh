#!/bin/bash
#SBATCH --nodes=1                    # Run all processes on a single node
#SBATCH --ntasks=32                   # Run 4 commands
#SBATCH --cpus-per-task=4           # Number of CPU cores per task
#SBATCH --time=2:00:00
#SBATCH --account=AIRC_Fortun21
#SBATCH --partition=m100_usr_prod
#SBATCH --qos=m100_qos_dbg
#SBATCH --job-name run_ctv
#SBATCH -o salida_equ
#SBATCH -e error_equ

module load profile/lifesc
module load autoload amber/2020
export OMP_NUM_THREADS=4

cd $SLURM_SUBMIT_DIR

i=1
echo "Step:" $i
k=`expr $i - 1`

mdin="fbox.in"
mdout="${i}-box.out"
prmtop="../top/hmass_ctv.parm7"
cpin="../top/cpin_ctv"
inpcrd="${k}-box.rst7"
restrt="${i}-box.rst7"
mdcrd="${i}-box.nc"
inpcrd="final.1.rst7"

mpirun -np 32 pmemd.MPI -O -i $mdin -o $mdout -p $prmtop -c $inpcrd -r $restrt -x $mdcrd -cpin $cpin

echo "----- Done step: $i -----"
