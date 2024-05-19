FROM ubuntu-base:latest

# Install WINE
ARG WINE_VERSION=staging
RUN dpkg --add-architecture i386 \
    && install -m 755 -d /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && VERSION_CODENAME=$(. /etc/os-release && echo $VERSION_CODENAME) \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$VERSION_CODENAME/winehq-$VERSION_CODENAME.sources \
    && apt-get update \
    && apt-get install -y --install-recommends winehq-$WINE_VERSION \
    && apt-get install -y \
         winbind \
         xvfb
    && rm -rf /var/lib/apt/lists/*

# Be sure to use --init when running
ENTRYPOINT ["/usr/bin/xvfb-run", "/usr/bin/wine64"]
CMD ["--help"]
