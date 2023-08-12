#!/bin/bash
set -eu -o pipefail

repo="$(realpath $(dirname $BASH_SOURCE[0]))"

echo "Linking dotfiles from ${repo}"

echo "linking ~/.gitconfig"
ln -sf "${repo}/.gitconfig" ~/.gitconfig

mkdir -p ~/script
for f in $(find ${repo}/script -type f); do
  dst="${f/"${repo}"/$HOME}"
  echo "linking ${dst}"
  mkdir -p "$(dirname $dst)"
  ln -sf "${f}" "${dst}"
done
