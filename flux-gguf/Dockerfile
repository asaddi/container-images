FROM ubuntu:jammy AS build

RUN --mount=id=apt-build,type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
    build-essential \
    git \
    python3 \
    python3-venv
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
git clone https://github.com/ggerganov/llama.cpp.git /build
cd /build
git checkout b3600
EOF

WORKDIR /build
COPY lcpp.patch .

RUN <<EOF
git apply lcpp.patch
make llama-quantize
EOF

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
python3 -m venv venv
venv/bin/pip wheel ./gguf-py

mkdir /install
cp llama-quantize gguf-*.whl /install
EOF

FROM ubuntu:jammy

RUN --mount=type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
    python3 \
    python3-pip
rm -rf /var/lib/apt/lists/*
EOF

WORKDIR /app
COPY --from=build --chmod=0755 /install/llama-quantize .
COPY --from=build /install/gguf-*.whl .
COPY convert.py .
RUN --mount=type=cache,target=/root/.cache/pip <<EOF
pip install --extra-index-url https://download.pytorch.org/whl/cpu \
    gguf-*.whl \
    torch \
    tqdm \
    safetensors \
    sentencepiece
EOF
