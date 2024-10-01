# Some things currently break in 3.12
FROM python:3.11-slim AS build

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
ARG UID=1000
ARG GID=1000

WORKDIR /ComfyUI

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI
git checkout $COMFYUI_TAG
python -m venv venv
venv/bin/pip install -r requirements.txt
chown -R $UID:$GID .
EOF

COPY --chown=$UID:$GID extra_model_paths.yaml docker-entrypoint.sh .

RUN <<EOF
groupadd --gid $GID comfy-user
useradd -d /ComfyUI --uid $UID --gid $GID -M -N comfy-user
install -d -o $UID -g $GID /data
chmod a+x docker-entrypoint.sh
EOF

FROM scratch

COPY --from=build / /

ARG UID=1000
ARG GID=1000

USER $UID:$GID
WORKDIR /ComfyUI
VOLUME ["/data"]
EXPOSE 8188/tcp

ENTRYPOINT ["/ComfyUI/docker-entrypoint.sh"]
