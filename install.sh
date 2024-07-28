#!/bin/bash -eu

if [ -z "$1" ]; then
  echo "Usage: $0 <dir> <list>"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $0 <dir> <list>"
  exit 1
fi

if [ ! -d "$1" ]; then
  mkdir -p "$1"
fi

list="$(cat "$2")"

cd "$1"

names="$(echo "$list" | sed -r 's@.*/(.*)\.git@\1@')"

for name in *; do
  if ! echo "$names" | grep -q "$name"; then
    echo "removing $name ..."
    rm -rf "$name"
  fi
done

for url in $(echo "$list"); do
  echo "processing $url ..."

  name="$(echo "$url" | sed -r 's@.*/(.*)\.git@\1@')"

  if [ -d "$name" ]; then
    cd "$name"
    git pull
    cd ..
  else
    git clone "$url"
  fi
done
