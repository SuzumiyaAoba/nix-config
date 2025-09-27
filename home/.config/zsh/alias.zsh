## grep
if [[ $(command -v rg) ]]; then
  alias grep='rg'
  alias rg="rg --hidden --glob '!.git'"

  if [[ $(command -v delta) ]]; then
     alias dg=_grep_with_delta
  fi
fi

function _grep_with_delta() {
    rg --json -C 2 $1 | delta
}

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
