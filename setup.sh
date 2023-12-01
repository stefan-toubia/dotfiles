#!/bin/bash
set -eu -o pipefail

repo="$(realpath $(dirname $BASH_SOURCE[0]))"

echo "Linking dotfiles from ${repo}"

function link() {
  local source="$1"
  local target="$2"

  if [ -h "${target}" ]; then
    return
  elif [ ! -e "${target}" ]; then
    mkdir -p "$(dirname $dst)"
    echo "linking ${dst}"
    ln -s "${source}" "${target}"
  else
    echo "${target} exists but is not a symlink"
  fi
}

link "${repo}/.zshrc" ~/.zshrc
link "${repo}/.gitconfig" ~/.gitconfig

mkdir -p ~/.config
for f in $(find ${repo}/.config -type f); do
  dst="${f/"${repo}"/$HOME}"
  link "${f}" "${dst}"
done

mkdir -p ~/script
for f in $(find ${repo}/script -type f); do
  dst="${f/"${repo}"/$HOME}"
  link "${f}" "${dst}"
done
