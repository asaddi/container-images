FROM build-cuda AS builder

WORKDIR /

RUN git clone https://github.com/ggerganov/llama.cpp.git build

WORKDIR /build

ARG GIT_HASH=master
RUN git checkout ${GIT_HASH} \
    && cmake -B build -DLLAMA_CUDA=on \
    && cmake --build build --config Release -j8

# Needs to be runtime or devel
FROM nvidia/cuda:12.5.0-runtime-ubuntu22.04

# Note: If it can't find libcuda.so.1, that means you forgot --gpus=all on "docker run".
# But libgomp1 definitely needs to be added.
RUN apt-get update \
    && apt-get install -y \
        libgomp1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /build/build/bin/llama-* .

ENTRYPOINT ["/app/llama-server"]
CMD ["--help"]

EXPOSE 8080
VOLUME ["/data"]
