#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <path>"
  exit 1
fi

path="$1"

for bin in $(find "$path" -type d -name bin); do
  export PATH="$bin:$PATH"
done
