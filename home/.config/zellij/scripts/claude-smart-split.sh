#!/usr/bin/env bash
#
# Claude Code セッションのディレクトリを使って Zellij ペインを分割するスクリプト
#
# 動作:
#   1. CLAUDECODE=1 かつ CLAUDE_CODE_SESSION_ID が設定されている場合は
#      そのセッションのディレクトリを使う (Claude Code の bash サブシェル内)
#   2. claude CLI/daemon プロセスが起動中の場合は
#      ~/.claude/jobs/*/state.json からセッション一覧を取得し、
#      1件なら自動選択、複数なら fzf で選択させる
#   3. いずれも該当しない場合は通常の Zellij ペイン分割にフォールバック

DIRECTION="${1:-down}"
JOBS_DIR="$HOME/.claude/jobs"

# Claude CLI / daemon が現在起動しているか確認
is_claude_running() {
    pgrep -f "\.local/bin/claude|\.local/share/claude/versions" > /dev/null 2>&1
}

# state.json からセッション情報を収集して表示用文字列を返す
# 出力形式: "<updatedAt>\t<shortId>\t<name>\t<state>\t<cwd>"
collect_sessions() {
    local state_files
    mapfile -t state_files < <(find "$JOBS_DIR" -name "state.json" -maxdepth 2 2>/dev/null)

    [[ ${#state_files[@]} -eq 0 ]] && return

    for f in "${state_files[@]}"; do
        jq -r '"\(.updatedAt // "")\t\(.daemonShort // "")\t\(.name // "unnamed")\t\(.state // "")\t\(.cwd // "")"' \
            "$f" 2>/dev/null
    done | sort -r  # updatedAt の降順 (最新が先頭)
}

detect_target_cwd() {
    # Case 1: Claude Code の bash サブシェル内 (CLAUDECODE=1 が設定済み)
    if [[ -n "${CLAUDECODE:-}" && -n "${CLAUDE_CODE_SESSION_ID:-}" ]]; then
        local short_id="${CLAUDE_CODE_SESSION_ID:0:8}"
        local state_file="$JOBS_DIR/$short_id/state.json"
        if [[ -f "$state_file" ]]; then
            jq -r '.cwd // empty' "$state_file" 2>/dev/null
            return 0
        fi
    fi

    # Case 2: claude プロセスが起動中の場合のみセッション選択を行う
    is_claude_running || return 0

    [[ -d "$JOBS_DIR" ]] || return 0

    local sessions
    sessions=$(collect_sessions)
    [[ -z "$sessions" ]] && return 0

    local count
    count=$(echo "$sessions" | wc -l | tr -d ' ')

    if [[ "$count" -eq 1 ]]; then
        # セッションが1件だけなら自動選択
        echo "$sessions" | cut -f5
    else
        # 複数セッションは fzf で選択
        local display
        display=$(
            echo "$sessions" | cut -f2- | awk -F'\t' '{
                state_icon = ($3 == "running") ? "▶" : ($3 == "blocked") ? "⏸" : "○"
                printf "%s  %-8s  %s [%s]  →  %s\n", state_icon, $1, $2, $3, $4
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

        # "→  <path>" の部分を抽出
        echo "$selected" | sed 's/.*→  *//'
    fi
}

TARGET_CWD=$(detect_target_cwd)

if [[ -n "$TARGET_CWD" && -d "$TARGET_CWD" ]]; then
    zellij action new-pane --direction "$DIRECTION" --cwd "$TARGET_CWD"
else
    zellij action new-pane --direction "$DIRECTION"
fi
