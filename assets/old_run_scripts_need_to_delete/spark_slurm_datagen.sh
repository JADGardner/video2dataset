#!/bin/bash
#SBATCH --job-name=spark_datagen
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=james.gardner@york.ac.uk
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes 2
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64gb
#SBATCH --output=%x_%j.out
#SBATCH --comment laion
#SBATCH --exclusive
#SBATCH --time=24:00:00

srun --comment laion bash worker_spark_on_slurm.sh
