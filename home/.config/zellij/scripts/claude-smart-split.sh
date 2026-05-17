#!/usr/bin/env bash
#
# このスクリプトは新しいタイルドペイン内で実行される。
# Claude Code セッションのディレクトリ一覧（重複排除）から選択し、
# そのディレクトリでシェルを起動する。

JOBS_DIR="$HOME/.claude/jobs"
TARGET_CWD=""

is_claude_running() {
    pgrep -f "\.local/bin/claude" > /dev/null 2>&1 || \
    pgrep -f "\.local/share/claude" > /dev/null 2>&1
}

# セッション一覧から cwd を収集して重複排除・ソートして返す
collect_unique_dirs() {
    while IFS= read -r f; do
        [[ -f "$f" ]] || continue
        jq -r '"\(.updatedAt // "")\t\(.cwd // "")"' "$f" 2>/dev/null
    done < <(find "$JOBS_DIR" -name "state.json" -maxdepth 2 2>/dev/null) \
        | sort -r \
        | cut -f2 \
        | awk '!seen[$0]++' \
        | grep -v '^$'
}

detect_target_cwd() {
    # Claude Code の bash サブシェル内にいる場合はそのセッションを直接使う
    if [[ -n "${CLAUDECODE:-}" && -n "${CLAUDE_CODE_SESSION_ID:-}" ]]; then
        local short_id="${CLAUDE_CODE_SESSION_ID:0:8}"
        local state_file="$JOBS_DIR/$short_id/state.json"
        if [[ -f "$state_file" ]]; then
            TARGET_CWD=$(jq -r '.cwd // empty' "$state_file" 2>/dev/null)
            return 0
        fi
    fi

    is_claude_running || return 0
    [[ -d "$JOBS_DIR" ]] || return 0

    local dirs
    dirs=$(collect_unique_dirs)
    [[ -z "$dirs" ]] && return 0

    local count
    count=$(echo "$dirs" | wc -l | tr -d ' ')

    if [[ "$count" -eq 1 ]]; then
        TARGET_CWD="$dirs"
    else
        local tmpfile
        tmpfile=$(mktemp)
        echo "$dirs" | fzf \
            --prompt="dir > " \
            --height=50% \
            --border=rounded \
            --border-label=" Claude Code " \
            --no-sort > "$tmpfile"

        if [[ $? -eq 0 ]]; then
            TARGET_CWD=$(cat "$tmpfile")
        fi
        rm -f "$tmpfile"
    fi
}

detect_target_cwd

if [[ -n "$TARGET_CWD" && -d "$TARGET_CWD" ]]; then
    cd "$TARGET_CWD"
fi

exec "${SHELL:-zsh}"
