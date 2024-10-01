# Some things currently break in 3.12
FROM python:3.11-slim

RUN --mount=type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get install -y \
    git \
    locales
rm -rf /var/lib/apt/lists/*
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
EOF

ENV LANG=en_US.utf8

ARG COMFYUI_TAG=v0.2.2
ARG COMFYUI_UID=1000
ARG COMFYUI_GID=1000

WORKDIR /ComfyUI

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
git checkout $COMFYUI_TAG
python -m venv venv
venv/bin/pip install -r requirements.txt
chown -R $COMFYUI_UID:$COMFYUI_GID .
EOF

COPY --chown=$COMFYUI_UID:$COMFYUI_GID extra_model_paths.yaml docker-entrypoint.sh .

RUN <<EOF
groupadd --gid $COMFYUI_GID comfy-user
useradd -d /ComfyUI --uid $COMFYUI_UID --gid $COMFYUI_GID -M -N comfy-user
install -d -o $COMFYUI_UID -g $COMFYUI_GID /data
chmod a+x docker-entrypoint.sh
EOF

USER $COMFYUI_UID:$COMFYUI_GID
VOLUME ["/data"]
EXPOSE 8188/tcp

ENTRYPOINT ["/ComfyUI/docker-entrypoint.sh"]
