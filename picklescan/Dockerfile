FROM python:3.12-slim

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install picklescan

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/picklescan"]
CMD ["--help"]
