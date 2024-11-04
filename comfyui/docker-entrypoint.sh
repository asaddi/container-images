#!/bin/bash

# WTF, Linux?
shopt -s nullglob

BASE="$(realpath "$(dirname "$0")")"

# Note: We use a symlink for custom_nodes because prestartup_scripts
# are only executed in the original custom_nodes directory, not any
# added by extra_model_paths.yaml. Is this a bug?
if [ ! -e /data/custom_nodes ]; then
    cp -Rp custom_nodes /data/custom_nodes
fi
mv custom_nodes custom_nodes.orig
ln -s /data/custom_nodes

# Ensure appropriate directories exist in the data volume
mkdir -p /data/user /data/input /data/output /data/models/checkpoints \
  /data/models/clip /data/models/clip_vision /data/models/configs \
  /data/models/controlnet /data/models/embeddings /data/models/loras \
  /data/models/text_encoders \
  /data/models/unet /data/models/upscale_models /data/models/vae \
  /data/pip-install

# Install any additional requirements/wheels in /data/pip-install
echo "==== Installing additional Python packages..."
logfile=$(mktemp)
pip_cmd=/ComfyUI/venv/bin/pip
for fn in /data/pip-install/*.txt /data/pip-install/*.whl; do
    echo -n "$fn: "
    case "$fn" in
	*.txt)
	    $pip_cmd install -r "$fn" >$logfile 2>&1
	    ;;
	*.whl)
	    $pip_cmd install "$fn" >$logfile 2>&1
	    ;;
    esac
    rc=$?
    if [ $rc -ne 0 ]; then
	echo "failed"
	cat $logfile
    else
	echo "ok"
    fi
done
rm -f $logfile
echo "==== Done"

if [ "$1" = "shell" ]; then
    shift
    exec /bin/bash "$@"
fi

exec $BASE/start.sh "$@"
