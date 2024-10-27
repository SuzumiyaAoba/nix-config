### fzf

# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf-tmux -p 80%)
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf
