# Note: My current feeling is that using pytorch image as base does not
# result in any space savings nor is it easier to use. Not that it made
# any such promises...
# But at least we don't need --extra-index-url?

FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

# OpenCV requires libGL which needs pthreads etc.
# Currently not sure if the -dev versions are actually needed

RUN --mount=type=cache,target=/var/cache/apt <<EOF
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
    libglib2.0-dev \
    libglu1-mesa-dev
rm -rf /var/lib/apt/lists/*
EOF

ARG PIP_INDEX_URL=https://pypi.org/simple

ENV PIP_INDEX_URL=$PIP_INDEX_URL

# Not sure if we really *need* opencv, but it's being used to normalize
# the RGB values between [-1,1]

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
pip install lpips opencv-python
EOF

COPY main.py .

WORKDIR /data
VOLUME ["/data"]
# Note: lpips downloads a model from HF(?)
VOLUME ["/root/.cache/torch"]

ENTRYPOINT ["/opt/conda/bin/python", "-i", "/workspace/main.py"]
