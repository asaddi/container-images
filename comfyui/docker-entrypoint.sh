#!/bin/sh
BASE="$(realpath "$(dirname "$0")")"

# Ensure appropriate directories exist in the data volume
mkdir -p /data/user /data/input /data/output /data/models/checkpoints \
  /data/models/clip /data/models/clip_vision /data/models/configs \
  /data/models/controlnet /data/models/embeddings /data/models/loras \
  /data/models/upscale_models /data/models/vae /data/custom_nodes

if [ "$1" = "shell" ]; then
    shift
    exec /bin/bash "$@"
fi

exec $BASE/start.sh "$@"
