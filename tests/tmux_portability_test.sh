#!/usr/bin/env bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOCKET="dotfiles-portability-test-$$"
CONTROL_SOCKET="dotfiles-portability-control-$$"
SESSION="portability-test"

cleanup() {
  tmux -L "$SOCKET" kill-server >/dev/null 2>&1 || true
  tmux -L "$CONTROL_SOCKET" kill-server >/dev/null 2>&1 || true
}
trap cleanup EXIT

tmux -L "$CONTROL_SOCKET" -f /dev/null new-session -d -s "$SESSION"
tmux -L "$SOCKET" -f "$ROOT/tmux/.tmux.conf" new-session -d -s "$SESSION"
sleep 0.1

if ! tmux -L "$SOCKET" has-session -t "$SESSION" 2>/dev/null; then
  printf 'not ok - tmux config preserves detected shell defaults\n'
  exit 1
fi

expected_shell="$(tmux -L "$CONTROL_SOCKET" show-options -gv default-shell)"
actual_shell="$(tmux -L "$SOCKET" show-options -gv default-shell)"
expected_command="$(tmux -L "$CONTROL_SOCKET" show-options -gv default-command)"
actual_command="$(tmux -L "$SOCKET" show-options -gv default-command)"

if [ "$actual_shell" != "$expected_shell" ] || [ "$actual_command" != "$expected_command" ]; then
  printf 'not ok - tmux config preserves detected shell defaults\n'
  printf 'expected shell=%s command=%s\n' "$expected_shell" "$expected_command"
  printf 'actual shell=%s command=%s\n' "$actual_shell" "$actual_command"
  exit 1
fi

printf 'ok - tmux config preserves detected shell defaults\n'
