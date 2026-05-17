#!/usr/bin/env bash
#
# このスクリプトは新しいタイルドペイン内で実行される。
# Claude Code セッションを選択し、そのディレクトリでシェルを起動する。

JOBS_DIR="$HOME/.claude/jobs"
TARGET_CWD=""

is_claude_running() {
    pgrep -f "\.local/bin/claude" > /dev/null 2>&1 || \
    pgrep -f "\.local/share/claude" > /dev/null 2>&1
}

collect_sessions() {
    local state_files=()
    while IFS= read -r f; do
        [[ -f "$f" ]] && state_files+=("$f")
    done < <(find "$JOBS_DIR" -name "state.json" -maxdepth 2 2>/dev/null)

    [[ ${#state_files[@]} -eq 0 ]] && return

    for f in "${state_files[@]}"; do
        jq -r '"\(.updatedAt // "")\t\(.daemonShort // "")\t\(.name // "unnamed")\t\(.state // "")\t\(.cwd // "")"' \
            "$f" 2>/dev/null
    done | sort -r
}

# $() のネストを避けるためグローバル変数 TARGET_CWD を直接セットする
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

    local sessions
    sessions=$(collect_sessions)
    [[ -z "$sessions" ]] && return 0

    local count
    count=$(echo "$sessions" | wc -l | tr -d ' ')

    if [[ "$count" -eq 1 ]]; then
        TARGET_CWD=$(echo "$sessions" | cut -f5)
    else
        # fzf を $() の外で直接呼び出す（ネスト回避）
        local display
        display=$(echo "$sessions" | cut -f2- | awk -F'\t' '{
            icon = ($3 == "running") ? "▶" : ($3 == "blocked") ? "⏸" : "○"
            printf "%s  %-8s  %s [%s]  →  %s\n", icon, $1, $2, $3, $4
        }')

        local tmpfile
        tmpfile=$(mktemp)
        # fzf の結果をテンポラリファイルに書き出す
        echo "$display" | fzf \
            --prompt="Claude session > " \
            --height=50% \
            --border=rounded \
            --border-label=" Claude Code Sessions " \
            --no-sort \
            --ansi > "$tmpfile"

        local fzf_exit=$?
        if [[ $fzf_exit -eq 0 ]]; then
            local selected
            selected=$(cat "$tmpfile")
            if [[ -n "$selected" ]]; then
                TARGET_CWD=$(echo "$selected" | sed 's/.*→  *//')
            fi
        fi
        rm -f "$tmpfile"
    fi
}

detect_target_cwd

if [[ -n "$TARGET_CWD" && -d "$TARGET_CWD" ]]; then
    cd "$TARGET_CWD"
fi

exec "${SHELL:-zsh}"
