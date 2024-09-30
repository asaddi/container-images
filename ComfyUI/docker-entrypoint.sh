#!/bin/sh
BASE="$(realpath "$(dirname "$0")")"

mkdir -p /data/input /data/output

# Move models and custom_nodes directories to /data, if needed
for dir_name in models custom_nodes; do
    # Copy the directory over
    if [ ! -d /data/$dir_name ]; then
        tar -cf - $dir_name | tar -C /data -xf -
    fi

    # And replace it with a symlink
    mv $dir_name $dir_name.old
    ln -s /data/$dir_name
done

if [ "$1" = "shell" ]; then
    shift
    exec /bin/bash "$@"
fi

exec $BASE/venv/bin/python main.py \
  --listen 0.0.0.0 \
  --disable-auto-launch \
  --input-directory /data/input \
  --output-directory /data/output \
  --temp-directory /data \
  "$@"
