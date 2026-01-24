#!/bin/bash
set -eu -o pipefail

# https://github.com/jakehilborn/displayplacer

displays=($(displayplacer list | grep "Persistent screen id" | sed -E 's/Persistent screen id: //g'))
displayplacer "id:${displays[2]} origin:(0,0)" "id:${displays[1]} res:1728x1117 origin:(-1728,575)" "id:${displays[0]} origin:(3008,0)"
