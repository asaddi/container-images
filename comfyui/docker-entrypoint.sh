#!/bin/sh
BASE="$(realpath "$(dirname "$0")")"

# Ensure appropriate directories exist in the data volume
mkdir -p /data/input /data/output /data/models/checkpoints \
  /data/models/clip /data/models/clip_vision /data/models/configs \
  /data/models/controlnet /data/models/embeddings /data/models/loras \
  /data/models/upscale_models /data/models/vae /data/custom_nodes

if [ "$1" = "shell" ]; then
    shift
    exec /bin/bash "$@"
fi

exec $BASE/venv/bin/python main.py \
  --input-directory /data/input \
  --output-directory /data/output \
  --temp-directory /data \
  "$@" \
  --listen 0.0.0.0 \
  --port 8188 \
  --disable-auto-launch
