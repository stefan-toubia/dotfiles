for config in ~/.config/zsh/{env,functions,aliases,completions,tools,interactive}.zsh; do
	[[ -r "$config" ]] && source "$config"
done

source_if ~/.env
source_if ~/.work.zshrc
