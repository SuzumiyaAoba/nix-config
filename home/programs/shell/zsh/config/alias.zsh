## grep
if [[ $(command -v rg) ]]; then
  alias grep='rg'
  alias rg="rg --hidden --glob '!.git'"
fi

## emacs
if [[ $(command -v emacs) ]]; then
    alias emacsd='emacsclient -nw -c -a ""'
    alias gemacsd='emacsclient -c -a "" &'
    alias killemacsd='emacsclient -e "(kill-emacs)"'
    alias e='emacs -nw'
    alias ge='emacs'
    alias ed='emacsd'
    alias ged='gemacsd'
    export EDITOR='emacs -nw'
fi

## vim
if [[ $(command -v nvim) ]]; then
  alias vim='nvim'
fi
