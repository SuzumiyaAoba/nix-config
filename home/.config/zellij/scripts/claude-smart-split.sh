#!/usr/bin/env bash
#
# このスクリプトは新しいタイルドペイン内で実行される。
# Claude Code セッションを選択し、そのディレクトリでシェルを起動する。

JOBS_DIR="$HOME/.claude/jobs"

is_claude_running() {
    pgrep -f "\.local/bin/claude|\.local/share/claude/versions" > /dev/null 2>&1
}

collect_sessions() {
    local state_files
    mapfile -t state_files < <(find "$JOBS_DIR" -name "state.json" -maxdepth 2 2>/dev/null)
    [[ ${#state_files[@]} -eq 0 ]] && return
    for f in "${state_files[@]}"; do
        jq -r '"\(.updatedAt // "")\t\(.daemonShort // "")\t\(.name // "unnamed")\t\(.state // "")\t\(.cwd // "")"' \
            "$f" 2>/dev/null
    done | sort -r
}

detect_target_cwd() {
    # Claude Code の bash サブシェル内にいる場合はそのセッションを直接使う
    if [[ -n "${CLAUDECODE:-}" && -n "${CLAUDE_CODE_SESSION_ID:-}" ]]; then
        local short_id="${CLAUDE_CODE_SESSION_ID:0:8}"
        local state_file="$JOBS_DIR/$short_id/state.json"
        if [[ -f "$state_file" ]]; then
            jq -r '.cwd // empty' "$state_file" 2>/dev/null
            return 0
        fi
    fi

    is_claude_running || return 0
    [[ -d "$JOBS_DIR" ]] || return 0

    local sessions
    sessions=$(collect_sessions)
    [[ -z "$sessions" ]] && return 0

    local count
    count=$(echo "$sessions" | wc -l | tr -d ' ')

    if [[ "$count" -eq 1 ]]; then
        echo "$sessions" | cut -f5
    else
        local display
        display=$(
            echo "$sessions" | cut -f2- | awk -F'\t' '{
                icon = ($3 == "running") ? "▶" : ($3 == "blocked") ? "⏸" : "○"
                printf "%s  %-8s  %s [%s]  →  %s\n", icon, $1, $2, $3, $4
            }'
        )
        local selected
        selected=$(echo "$display" | fzf \
            --prompt="Claude session > " \
            --height=50% \
            --border=rounded \
            --border-label=" Claude Code Sessions " \
            --no-sort \
            --ansi) || return 0
        [[ -z "$selected" ]] && return 0
        echo "$selected" | sed 's/.*→  *//'
    fi
}

TARGET_CWD=$(detect_target_cwd)

if [[ -n "$TARGET_CWD" && -d "$TARGET_CWD" ]]; then
    cd "$TARGET_CWD"
fi

exec "${SHELL:-zsh}"
