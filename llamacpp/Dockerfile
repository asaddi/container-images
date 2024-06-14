# Needs to be runtime or devel
FROM nvidia/cuda:12.5.0-runtime-ubuntu22.04

# Note: If it can't find libcuda.so.1, that means you forgot --gpus=all on "docker run"
RUN apt-get update \
    && apt-get install -y \
        libgomp1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY bin/* .

ENTRYPOINT ["/app/llama-server"]
CMD ["--help"]

EXPOSE 8080
VOLUME ["/data"]
