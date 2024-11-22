FROM python:3.12-slim

RUN --mount=type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get install -y \
    git \
    libglib2.0-dev \
    libglu1-mesa-dev \
    locales
rm -rf /var/lib/apt/lists/*
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
EOF

ENV LANG=en_US.utf8

ARG COMFYUI_TAG=v0.2.7
ARG UID=1000
ARG GID=1000

RUN <<EOF
groupadd --gid $GID comfy-user
useradd -d /ComfyUI --uid $UID --gid $GID -M -N comfy-user
install -d -o $UID -g $GID /data
EOF

USER $UID:$GID

WORKDIR /ComfyUI

RUN <<EOF
git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
git checkout $COMFYUI_TAG
EOF

ARG PIP_INDEX_URL=https://pypi.org/simple
ARG PIP_EXTRA_INDEX_URL=https://download.pytorch.org/whl/cu124

ENV PIP_INDEX_URL=$PIP_INDEX_URL
ENV PIP_EXTRA_INDEX_URL=$PIP_EXTRA_INDEX_URL

RUN --mount=type=cache,uid=$UID,gid=$GID,target=/ComfyUI/.cache/pip <<EOF
python -m venv venv
venv/bin/pip install -U pip setuptools
venv/bin/pip install -r requirements.txt
EOF

COPY --chown=$UID:$GID extra_model_paths.yaml .
COPY --chown=$UID:$GID --chmod=755 docker-entrypoint.sh start.sh .

VOLUME ["/data"]
EXPOSE 8188/tcp

ENTRYPOINT ["/ComfyUI/docker-entrypoint.sh"]
