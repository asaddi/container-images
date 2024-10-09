FROM python:3.10-slim AS build

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

ARG SD_WEBUI_TAG=v1.10.1
ARG UID=1000
ARG GID=1000

WORKDIR /sd-webui

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /sd-webui
git checkout $SD_WEBUI_TAG
python -m venv venv
venv/bin/pip install -r requirements.txt
chown -R $UID:$GID .
EOF

COPY --chown=$UID:$GID docker-entrypoint.sh start.sh .

RUN <<EOF
groupadd --gid $GID sd-user
useradd -d /sd-webui --uid $UID --gid $GID -M -N sd-user
install -d -o $UID -g $GID /data
chmod a+x docker-entrypoint.sh start.sh
EOF

FROM scratch

COPY --from=build / /

ARG UID=1000
ARG GID=1000

USER $UID:$GID
WORKDIR /sd-webui
VOLUME ["/data"]
EXPOSE 7860/tcp

ENTRYPOINT ["/sd-webui/docker-entrypoint.sh"]
