ARG UBUNTU_VERSION=24.04
FROM ubuntu:$UBUNTU_VERSION

RUN --mount=type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
    binutils \
    cargo \
    git \
    libssl-dev \
    pkg-config \
    rustc
rm -rf /var/lib/apt/lists/*
EOF

WORKDIR /build

COPY --chmod=0755 go.sh .

ENV EFS_UTILS_VERSION=v2.1.0
CMD ["./go.sh"]
