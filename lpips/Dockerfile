# Note: My current feeling is that using pytorch image as base does not
# result in any space savings nor is it easier to use. Not that it made
# any such promises...
# But at least we don't need --extra-index-url?

FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

ARG PIP_INDEX_URL=https://pypi.org/simple

ENV PIP_INDEX_URL=$PIP_INDEX_URL

RUN --mount=type=cache,target=/root/.cache/pip <<EOF
pip install lpips
EOF

COPY main.py .

WORKDIR /data
VOLUME ["/data"]
# Note: lpips downloads a model from HF(?)
VOLUME ["/root/.cache/torch"]

ENTRYPOINT ["/opt/conda/bin/python", "/workspace/main.py"]
CMD ["--help"]
