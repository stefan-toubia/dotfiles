#!/bin/bash
set -eu
dest="$1"
target="$2"
source="$3"
base="${target}.base"
cp "$target" "$base"
cursor --new-window --wait --merge "$dest" "$target" "$base" "$source"
