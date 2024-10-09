#!/bin/sh
BASE="$(realpath "$(dirname "$0")")"

redir() {
    local datadir=/data/$1
    mkdir -p $1
    if [ ! -e $datadir ]; then
        cp -Rp $1 /data/
    fi
    mv $1 $1.old
    ln -s $datadir
}


# Ensure appropriate directories exist in the data volume
redir configs
redir models
redir repositories

if [ "$1" = "shell" ]; then
    shift
    exec /bin/bash "$@"
fi

exec $BASE/start.sh "$@"
