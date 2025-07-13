#!/bin/bash
set -eu -o pipefail

if [[ -z $(git branch --remotes --contains $(git rph)) ]]; then
	echo "Branch is not pushed to remote"
	exit 1
fi
if [[ -n $(git status --porcelain) ]]; then
	echo "Uncommitted changes"
	exit 1
fi
