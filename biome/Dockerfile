FROM node:22-slim

RUN --mount=type=cache,target=/root/.npm <<EOF
npm install --global @biomejs/biome
EOF

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/usr/local/bin/biome"]
CMD ["--help"]
