FROM build-cuda AS builder

WORKDIR /

RUN git clone https://github.com/LostRuins/koboldcpp.git build

WORKDIR /build

ARG GIT_HASH=concedo
ARG CUDA_DOCKER_ARCH
ENV CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH:-all}

RUN git checkout ${GIT_HASH} \
    && make -j8 LLAMA_CUBLAS=1

# Needs to be runtime or devel
FROM nvidia/cuda:12.5.0-runtime-ubuntu22.04

RUN apt-get update \
    && apt-get install -y \
        python3 \
        python3-venv \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/requirements.txt /tmp

WORKDIR /app

RUN python3 -m venv venv \
    && venv/bin/pip install -r /tmp/requirements.txt

COPY --from=builder \
    /build/*.embd \
    /build/koboldcpp_*.so \
    /build/koboldcpp.py \
    .

COPY koboldcpp.sh .

ENTRYPOINT ["/app/koboldcpp.sh"]
CMD ["--help"]
