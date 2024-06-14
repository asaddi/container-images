# Needs to be runtime or devel
FROM nvidia/cuda:12.5.0-runtime-ubuntu22.04

RUN apt-get update \
    && apt-get install -y \
        python3 \
        python3-venv \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /app

WORKDIR /tmp

COPY requirements.txt .

RUN python3 -m venv /app/venv \
    && /app/venv/bin/pip install -r requirements.txt

WORKDIR /app

COPY *.embd koboldcpp_cublas.so koboldcpp_default.so koboldcpp.py koboldcpp.sh .

ENTRYPOINT ["/app/koboldcpp.sh"]
CMD ["--help"]
