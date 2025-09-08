setopt beep # Enable beep sound for certain commands.  Useful for feedback.

export LANG=ja_JP.UTF-8

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

plugins=(git)

eval "$(sheldon source)"

source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/keybinds.zsh"

export PATH="$HOME/.local/bin:$PATH"
