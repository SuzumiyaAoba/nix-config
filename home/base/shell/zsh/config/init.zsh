setopt no_beep

source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/keybinds.zsh"

bin=(
    "volta"
    "sdkman"
    "rancher"
)

for filename in $bin; do
    local FILE_PATH="$HOME/.config/zsh/programs/$filename.zsh"
    if [ -e $FILE_PATH ]; then
	source $FILE_PATH
    fi
done
