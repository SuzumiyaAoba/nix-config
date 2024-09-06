source "$HOME/.config/zsh/tmux.zsh"

setopt no_beep

export LANG=ja_JP.UTF-8

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

source "$HOME/.config/zsh/plugins.zsh"
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/keybinds.zsh"

bin=(
    "sdkman"
    "rancher"
    "deno"
    "atuin"
)

for filename in $bin; do
    local FILE_PATH="$HOME/.config/zsh/programs/$filename.zsh"
    if [ -e $FILE_PATH ]; then
	source $FILE_PATH
    fi
done
