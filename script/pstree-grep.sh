#!/bin/bash
set -eu -o pipefail

pattern="$1"
pid=$(ps aux | grep "${pattern}" | cut -w -f2)
if [ -z "$pid" ]; then
  echo "No process found matching '${pattern}'"
  return 1
fi
pstree "$pid"
