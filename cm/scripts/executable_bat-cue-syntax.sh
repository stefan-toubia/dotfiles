#!/bin/bash
set -eu -o pipefail

bat_syntaxes="${XDG_CONFIG_HOME:-$HOME/.config}/bat/syntaxes"
mkdir -p "$bat_syntaxes"
curl -fsSL https://raw.githubusercontent.com/patopesto/Sublime-Text-Cuelang-Syntax/master/cue.sublime-syntax -o "$bat_syntaxes/CUE.sublime-syntax"
bat cache --build
