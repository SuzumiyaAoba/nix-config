## ls
if [[ $(command -v exa) ]]; then
  alias l='clear && ls'
  alias ls='eza --icons --git'
  alias ll='eza -ahl --icons --git'
  alias lt='eza -T -L 3 -a -I ".git" --git-ignore --icons'
  alias lta='eza -T -a -I ".git" --git-ignore --color=always --icons | less -r'
fi

## grep
if [[ $(command -v rg) ]]; then
  alias grep='rg'
  alias rg="rg --hidden --glob '!.git'"
fi

## cat
if [[ $(command -v bat) ]]; then
  alias cat='bat'
fi

## emacs
if [[ $(command -v emacs) ]]; then
    alias emacs='emacsclient -nw -c -a ""'
    alias gemacs='emacsclient -c -a "" &'
    alias killemacs='emacsclient -e "(kill-emacs)"'
    alias e='emacs'
    alias ge='gemacs'
    export EDITOR='emacsclient -c -a ""'
fi

## vim
if [[ $(command -v nvim) ]]; then
  alias vim='nvim'
fi
