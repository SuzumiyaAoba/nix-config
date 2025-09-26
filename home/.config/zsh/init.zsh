setopt beep # Enable beep sound for certain commands.  Useful for feedback.

export LANG=ja_JP.UTF-8

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

# Plugin manager initialization is now handled by programs.zsh.initExtra in respective modules
# Original sheldon initialization:
# eval "$(sheldon source)"

source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/keybinds.zsh"
source "$HOME/.config/zsh/programs/init.zsh"

export PATH="$HOME/.local/bin:$PATH"
