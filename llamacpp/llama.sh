#!/bin/sh

export LD_LIBRARY_PATH=/app/lib

BASE=$(dirname "$0")/bin

if [ $# -lt 1 -o "$1" = "--help" -o "$1" = "-h" ]; then
  {
    echo "Usage: $0 <command> [args...]"
    echo
    echo "Available commands:"
    cd $BASE
    for fn in llama-*; do
      cmd=$(echo "$fn" | cut -c 7-)
      echo "  $cmd"
    done
    exit 1
  } >&2
fi

cmd=$1

shift

if [ ! -x $BASE/llama-$cmd ]; then
  echo "$0: Unknown command '$cmd'" >&2
  exit 2
fi

exec $BASE/llama-$cmd "$@"
