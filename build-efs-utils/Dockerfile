ARG UBUNTU_VERSION=noble
FROM ubuntu:$UBUNTU_VERSION

RUN apt-get update \
    && apt-get install -y \
         git \
         binutils \
         rustc \
         cargo \
         pkg-config \
         libssl-dev \
    && rm -rf /var/lib/apt/lists/*
