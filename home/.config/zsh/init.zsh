setopt beep # Enable beep sound for certain commands.  Useful for feedback.

export LANG=ja_JP.UTF-8

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

# Zsh plugin loading is configured declaratively in modules/programs/zsh.nix.

source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/keybinds.zsh"
source "$HOME/.config/zsh/programs/init.zsh"

export PATH="$HOME/.local/bin:$PATH"
