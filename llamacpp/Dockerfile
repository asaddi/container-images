ARG CUDA_VERSION=12.5.0
ARG UBUNTU_VERSION=22.04

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION} AS builder

RUN --mount=id=apt-builder,type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y \
        cmake \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ggerganov/llama.cpp.git /build

WORKDIR /build

ARG GIT_HASH=master
# Not sure if the following is needed with cmake. Leave it out since it works fine without.
#ARG CUDA_DOCKER_ARCH
#ENV CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH:-all}

RUN git checkout ${GIT_HASH} \
    && cmake -B build -DLLAMA_CUDA=on \
    && cmake --build build --config Release -j8

# Needs to be runtime or devel
FROM nvidia/cuda:${CUDA_VERSION}-runtime-ubuntu${UBUNTU_VERSION}

# Note: If it can't find libcuda.so.1, that means you forgot --gpus=all on "docker run".
# But libgomp1 definitely needs to be added.
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y \
        libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Ideally, we would also install the Python dependencies, but that seems to add another GB or two.

WORKDIR /app

# TODO Selectively copy the binaries we need since they're HUGE
COPY --from=builder /build/build/bin/llama-* .
COPY llama.sh .
RUN chmod a+rx llama.sh

ENTRYPOINT ["/app/llama.sh"]
CMD ["--help"]

EXPOSE 8080
