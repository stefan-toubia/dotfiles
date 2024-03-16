#!/bin/bash
set -eu -o pipefail

# Generate a Go pseudo-version based on the current git commit.

commit_hash=$(git rev-parse --short=12 HEAD)
timestamp=$(git show -s --format=%ci $commit_hash)
formatted_timestamp=$(date -u -j -f "%Y-%m-%d %H:%M:%S %z" "$timestamp" "+%Y%m%d%H%M%S")

echo "v0.0.0-$formatted_timestamp-$commit_hash"
