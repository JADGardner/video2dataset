#!/bin/bash
#SBATCH --job-name=datagen_roteqssl
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=james.gardner@york.ac.uk
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task=96
#SBATCH --mem=256gb
#SBATCH --output=%x_%j.out
#SBATCH --time=48:00:00
#SBATCH --partition=nodes

source ~/.bashrc

conda activate roteqssl

video2dataset --url_list="roteqssl/assets/equirectangular_video_urls.txt" \
              --input_format="txt" \
              --output_folder="data/video2dataset_data_nodes" \
              --output_format="files" \
              --url_col="url" \
              --caption_col="caption" \
              --enable_wandb=True \
              --max_shard_retry=2 \
              --config="roteqssl/assets/yt_360_config.yaml"
