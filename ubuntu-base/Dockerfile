ARG UBUNTU_VERSION=latest
FROM ubuntu:$UBUNTU_VERSION

# Update the system, install a few common pre-reqs, set locale
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
         locales \
         wget \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8
