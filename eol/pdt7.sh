#!/bin/bash
#SBATCH --nodes=1                    # Run all processes on a single node
#SBATCH --ntasks=1                   # Run 4 commands
#SBATCH --cpus-per-task=4           # Number of CPU cores per task
#SBATCH --gres=gpu:1
#SBATCH --time=24:00:00
#SBATCH --account=AIRC_Fortun21
#SBATCH --partition=m100_usr_prod
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pbarletta@gmail.com
#SBATCH --job-name run_eol_7
#SBATCH -o salida_pdt_eol
#SBATCH -e error_pdt_eol
#SBATCH --depend=afterany:6509944

module load profile/lifesc
module load autoload amber/2020

cd $SLURM_SUBMIT_DIR

i=7
echo "Step:" $i
k=`expr $i - 1`

mdin="pdt.in"
mdout="${i}-pdt.out"
prmtop="./top/hmass_eol.parm7"
cpin="./top/cpin_eol"
inpcrd="${k}-pdt.rst7"
restrt="${i}-pdt.rst7"
mdcrd="${i}-pdt.nc"

if [ $i == 1 ]
then
    inpcrd="./pre/final.1.rst7"
fi

pmemd.cuda -O -i $mdin -o $mdout -p $prmtop -c $inpcrd -r $restrt -x $mdcrd -cpin $cpin

echo "----- Done step: $i -----"
