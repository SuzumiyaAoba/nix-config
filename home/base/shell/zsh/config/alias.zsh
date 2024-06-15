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
    alias emacsd='emacsclient -nw -c -a ""'
    alias gemacsd='emacsclient -c -a "" &'
    alias killemacsd='emacsclient -e "(kill-emacs)"'
    alias e='emacs'
    alias ed='emacsd'
    alias ged='gemacsd'
    export EDITOR='emacs'
fi

## vim
if [[ $(command -v nvim) ]]; then
  alias vim='nvim'
fi
