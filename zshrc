for config in ~/.config/zsh/{env,functions,aliases,tools,completions,interactive}.zsh; do
	[[ -r "$config" ]] && source "$config"
done

plugins=(autosuggestions syntax-highlighting)
for plugin in $plugins; do
	source_if ~/.config/zsh-plugins/zsh-$plugin/zsh-$plugin.zsh
done

source_if ~/.env
source_if ~/.work.zshrc
