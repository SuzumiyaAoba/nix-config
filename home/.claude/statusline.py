#!/usr/bin/env python3
"""Pattern 4: Fine-grained progress bar with true color gradient"""
from datetime import datetime
import json
import os
import subprocess
import sys

if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

data = json.load(sys.stdin)

BLOCKS = ' ▏▎▍▌▋▊▉█'
BRANCH_ICON = ''
R = '\033[0m'
DIM = '\033[2m'
WEEKDAYS = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')

def gradient(pct):
    if pct < 50:
        r = int(pct * 5.1)
        return f'\033[38;2;{r};200;80m'
    else:
        g = int(200 - (pct - 50) * 4)
        return f'\033[38;2;255;{max(g,0)};60m'

def bar(pct, width=10):
    pct = min(max(pct, 0), 100)
    filled = pct * width / 100
    full = int(filled)
    frac = int((filled - full) * 8)
    b = '█' * full
    if full < width:
        b += BLOCKS[frac]
        b += '░' * (width - full - 1)
    return b

def fmt(label, pct):
    p = round(pct)
    return f'{label} {gradient(pct)}{bar(pct)} {p}%{R}'


def format_reset_label(label, resets_at, include_weekday=False):
    if resets_at is None:
        return label

    reset_dt = datetime.fromtimestamp(resets_at)
    time_text = reset_dt.strftime('%H:%M')
    if not include_weekday:
        return f'{label} ({time_text})'

    weekday = WEEKDAYS[reset_dt.weekday()]
    return f'{label} ({weekday} {time_text})'


def directory_name(path):
    norm = os.path.normpath(path or os.getcwd())
    name = os.path.basename(norm)
    return name or norm


def git_branch(path):
    try:
        result = subprocess.run(
            ['git', '-C', path, 'branch', '--show-current'],
            capture_output=True,
            check=False,
            text=True,
        )
    except OSError:
        return None

    branch = result.stdout.strip()
    if result.returncode != 0 or not branch:
        return None
    return branch

model = data.get('model', {}).get('display_name', 'Claude')
parts = [model]

ctx = data.get('context_window', {}).get('used_percentage')
if ctx is not None:
    parts.append(fmt('ctx', ctx))

five_limit = data.get('rate_limits', {}).get('five_hour', {})
five = five_limit.get('used_percentage')
if five is not None:
    parts.append(fmt(format_reset_label('5h', five_limit.get('resets_at')), five))

week_limit = data.get('rate_limits', {}).get('seven_day', {})
week = week_limit.get('used_percentage')
if week is not None:
    parts.append(fmt(format_reset_label('7d', week_limit.get('resets_at'), include_weekday=True), week))

workspace = data.get('workspace', {})
worktree = data.get('worktree', {})
current_dir = workspace.get('current_dir') or data.get('cwd') or os.getcwd()

if worktree.get('name'):
    repo_dir = worktree.get('original_cwd') or workspace.get('project_dir') or current_dir
    location = f"{directory_name(repo_dir)} [{BRANCH_ICON} {worktree['name']}]"
else:
    location = directory_name(current_dir)

    branch = git_branch(current_dir)
    if branch:
        location = f'{location} [{BRANCH_ICON} {branch}]'

parts.append(location)
print(f'{DIM}│{R}'.join(f' {p} ' for p in parts), end='')
