#!/bin/bash
set -eu -o pipefail

# List local branches ordered by most recent commit (committerdate).
git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)'
