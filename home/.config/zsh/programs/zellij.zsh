if [[ "$TERM_PROGRAM" == 'vscode' ]]; then
else
  if [[ -z "$VSCODE_RESOLVING_ENVIRONMENT" ]]; then
    # export ZELLIJ_AUTO_ATTACH=true
    export ZELLIJ_AUTO_EXIT=true
    eval "$(zellij setup --generate-auto-start zsh)"
  fi
fi

function current_dir() {
    local current_dir=$PWD
    if [[ $current_dir == $HOME ]]; then
        current_dir="~"
    else
        current_dir=${current_dir##*/}
    fi

    echo $current_dir
}

function change_tab_title() {
    local title=$1
    command nohup zellij action rename-tab $title >/dev/null 2>&1
}

function change_pane_title() {
    local title=$1
    command nohup zellij action rename-pane $title >/dev/null 2>&1
}

function set_tab_to_working_dir() {
    local result=$?
    local title=$(current_dir)

    change_tab_title $title
}

function set_pane_to_working_dir() {
    local result=$?
    local title=$(current_dir)

    change_pane_title $title
}

function set_tab_to_command_line() {
    local cmdline=$1
    change_tab_title $cmdline
}

function set_pane_to_command_line() {
    local cmdline=$1
    change_pane_title $title
}

if [[ -n $ZELLIJ ]]; then
    add-zsh-hook precmd set_tab_to_working_dir
    add-zsh-hook precmd set_pane_to_working_dir

    add-zsh-hook preexec set_tab_to_command_line
    add-zsh-hook preexec set_pane_to_command_line
fi
