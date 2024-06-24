ARG UBUNTU_VERSION=noble
FROM ubuntu:$UBUNTU_VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y \
         binutils \
         cargo \
         git \
         libssl-dev \
         pkg-config \
         rustc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY go.sh .
RUN chmod a+rx go.sh

ENV EFS_UTILS_VERSION=v2.0.3
CMD ["./go.sh"]
