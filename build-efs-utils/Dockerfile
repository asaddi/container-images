FROM ubuntu-base:latest

RUN apt-get update \
    && apt-get install -y \
         git \
         binutils \
         rustc \
         cargo \
         pkg-config \
         libssl-dev \
    && rm -rf /var/lib/apt/lists/*
