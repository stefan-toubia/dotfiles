#!/bin/bash
set -eu -o pipefail

repo="$(realpath $(dirname $BASH_SOURCE[0]))"

echo "Linking dotfiles from ${repo}"

function link() {
  local source="$1"
  local target="$2"

  if [ -h "${target}" ]; then
    if [ "$(readlink "${target}")" == "${source}" ]; then
      return
    else
      echo "${target} is a symlink to a different file"
      return
    fi
  elif [ ! -e "${target}" ]; then
    mkdir -p "$(dirname ${target})"
    echo "linking ${target}"
    ln -s "${source}" "${target}"
  else
    echo "${target} exists but is not a symlink"
  fi
}

link "${repo}/.zshrc" ~/.zshrc
link "${repo}/.gitconfig" ~/.gitconfig

mkdir -p ~/.config
for d in $(find ${repo}/.config -mindepth 1 -maxdepth 1 -type d); do
  dst="${d/"${repo}"/$HOME}"
  link "${d}" "${dst}"
done

mkdir -p ~/script
for f in $(find ${repo}/script -type f); do
  dst="${f/"${repo}"/$HOME}"
  link "${f}" "${dst}"
done
