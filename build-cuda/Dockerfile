FROM nvidia/cuda:12.5.0-devel-ubuntu22.04

RUN apt-get update \
    && apt-get install -y \
        git \
        cmake \
    && rm -rf /var/lib/apt/lists/*

VOLUME ["/build"]
