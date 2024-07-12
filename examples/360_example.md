```bash
video2dataset --url_list="360_urls.txt" \
              --input_format="txt" \
              --output_folder="dataset" \
              --output_format="files" \
              --url_col="url" \
              --caption_col="caption" \
              --enable_wandb=True \
              --config="video2dataset_config.yaml"
```

video2dataset --url_list="videos.csv" --url_col="url" --caption_col="caption" --output_folder="dataset"