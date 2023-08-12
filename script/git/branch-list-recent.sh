#!/bin/bash
set -eu -o pipefail

# List branches ordered by most recent checkout.
git reflog |
  egrep -io "moving from ([^[:space:]]+)" |
  awk '{ print $3 }' |
  awk '!a[$0]++' |
  grep -Fxf <(git branch | cut -c 3-) | # filter by local branches
  fzf
