#!/bin/bash
set -eu -o pipefail

# Interactive git commit selection with fzf and preview
selected_line=$(git log --oneline --graph --decorate --color=always -n 1000 |
  fzf --ansi --preview 'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --color=always' \
    --no-sort \
    --preview-window=right:40% \
    --bind 'enter:accept' \
    --header 'Select a commit (Enter to copy hash)')

if [ -n "$selected_line" ]; then
  echo "$selected_line"
  echo "$selected_line" | grep -o "[a-f0-9]\{7,\}" | head -1 | pbcopy
fi
