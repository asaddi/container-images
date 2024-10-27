#!/bin/sh
BASE="$(realpath "$(dirname "$0")")"
exec $BASE/venv/bin/python main.py \
  --user-directory /data/user \
  --input-directory /data/input \
  --output-directory /data/output \
  --temp-directory /data \
  "$@" \
  --listen 0.0.0.0 \
  --port 8188 \
  --disable-auto-launch
