#!/bin/sh

set -e

SRC="$1"
cp $SRC/koboldcpp_cublas.so \
   $SRC/koboldcpp_default.so \
   $SRC/koboldcpp.py \
   $SRC/requirements.txt \
   $SRC/*.embd \
   .
