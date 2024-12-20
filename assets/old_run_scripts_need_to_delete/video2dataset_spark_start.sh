#!/bin/bash

python roteqssl/scripts/video2dataset_datagen_spark.py --url_list="roteqssl/assets/equirectangular_video_urls_sample.txt" \
                                                       --input_format="txt" \
                                                       --output_folder="dataset" \
                                                       --output_format="files" \
                                                       --url_col="url" \
                                                       --caption_col="caption" \
                                                       --enable_wandb=True \
                                                       --config="roteqssl/assets/yt_360_config.yaml" \
                                                       --master_node="gpu04.viking2.yor.alces.network" \
                                                       --num_cores=8 \
                                                       --mem_gb=64
