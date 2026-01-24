#!/bin/zsh
set -eu -o pipefail

cmd="${1:-review}"

table_template='{{ range . -}}
{{ $labels := (join " " (pluck "name" .labels)) }}
{{- $draft := "" }}{{ if .isDraft }}{{ $draft = "DRAFT" }}{{ end }}
{{- tablerow .number .headRefName .title $draft (timeago .createdAt) $labels -}}
{{ end }}{{ tablerender }}'

case "$cmd" in
"review")
	gh pr ls --search 'is:open is:pr review-requested:@me' --json number,title,headRefName,createdAt,labels,isDraft --template "$table_template"
	;;
"review-pick")
	$0 review |
		GH_FORCE_TTY='100%' fzf --no-sort \
			--header 'Enter: Copy branch name | Ctrl+O: Open in browser | Ctrl+Y: Checkout branch' \
			--bind 'ctrl-o:execute-silent(gh pr view --web {1})+abort' \
			--bind 'ctrl-y:execute-silent(gh pr checkout {1})+abort' \
			--exact \
			--preview-window=up:70% --preview 'gh pr view {1}' |
		awk '{ print $2 }' |
		tee >(pbcopy)
	;;
*)
	echo "Invalid command"
	exit 1
	;;
esac
