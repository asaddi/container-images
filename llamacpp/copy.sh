#!/bin/sh

set -e

SRC="$1"

mkdir -p bin
cp $SRC/build/bin/llama-* bin/
