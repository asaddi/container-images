#!/bin/sh
BASE="$(realpath "$(dirname "$0")")"
cd $BASE
exec /usr/bin/bash webui.sh \
  --data-dir /data \
  "$@" \
  --listen \
  --port 7860
