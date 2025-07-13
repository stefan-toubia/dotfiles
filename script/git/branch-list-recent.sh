#!/bin/bash
set -eu -o pipefail

# List branches ordered by most recent checkout.
git reflog |
	rg -io "moving from ([^\s]+)" |
	awk '{ print $3 }' |
	awk '!a[$0]++' |
	rg --color never -Fxf <(git branch | cut -c 3-) # filter by local branches
