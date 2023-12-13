alias emacs = emacsclient -nw -c -a ""
alias gemacs = emacsclient -c -a ""
alias killemacs = emacsclient -e "(kill-emacs)"
alias e = emacs
alias ge = gemacs

$env.EDITOR = "emacsclient -nw -c -a ''"

$env.config = {
  show_banner: false,
  edit_mode: "emacs"
}
