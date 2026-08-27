#!/usr/bin/env bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILURES=0
TEST_DIRS=""

cleanup() {
  for dir in $TEST_DIRS; do
    rm -rf "$dir"
  done
}
trap cleanup EXIT

run_test() {
  local name="$1"
  shift

  if "$@"; then
    printf 'ok - %s\n' "$name"
  else
    printf 'not ok - %s\n' "$name"
    FAILURES=$((FAILURES + 1))
  fi
}

test_installer_provisions_plugins() {
  local test_dir
  test_dir="$(mktemp -d)"
  TEST_DIRS="$TEST_DIRS $test_dir"
  mkdir -p "$test_dir/bin" "$test_dir/home"

  cat > "$test_dir/bin/curl" <<'EOF'
#!/bin/sh
cat <<'INSTALL'
mkdir -p "$HOME/.oh-my-zsh/custom/themes"
: > "$HOME/.oh-my-zsh/oh-my-zsh.sh"
INSTALL
EOF

  cat > "$test_dir/bin/git" <<'EOF'
#!/bin/sh
for argument in "$@"; do
  destination="$argument"
done
mkdir -p "$destination"
EOF

  chmod +x "$test_dir/bin/curl" "$test_dir/bin/git"

  PATH="$test_dir/bin:/usr/bin:/bin" HOME="$test_dir/home" \
    bash "$ROOT/install/common.sh" >/dev/null

  local plugin
  for plugin in \
    zsh-npm-scripts-autocomplete \
    zsh-autosuggestions \
    zsh-syntax-highlighting; do
    if [ ! -d "$test_dir/home/.oh-my-zsh/custom/plugins/$plugin" ]; then
      printf 'missing plugin directory: %s\n' "$plugin"
      return 1
    fi
  done
}

test_zshrc_loads_configured_plugins() {
  local test_dir
  test_dir="$(mktemp -d)"
  TEST_DIRS="$TEST_DIRS $test_dir"
  mkdir -p "$test_dir/home/.oh-my-zsh/custom/themes/powerlevel10k"

  cat > "$test_dir/home/.oh-my-zsh/oh-my-zsh.sh" <<'EOF'
printf '%s\n' "${plugins[@]}" > "$HOME/plugins-loaded"
EOF
  : > "$test_dir/home/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
  : > "$test_dir/home/.p10k.zsh"

  HOME="$test_dir/home" zsh -dfc "source '$ROOT/zsh/.zshrc'"

  local expected actual
  expected='git
zsh-npm-scripts-autocomplete
zsh-autosuggestions
zsh-syntax-highlighting'
  actual="$(cat "$test_dir/home/plugins-loaded")"

  if [ "$actual" != "$expected" ]; then
    printf 'plugins visible to Oh My Zsh:\n%s\n' "$actual"
    return 1
  fi
}

run_test 'installer provisions third-party plugins' test_installer_provisions_plugins
run_test 'zshrc configures plugins before loading Oh My Zsh' test_zshrc_loads_configured_plugins

exit "$FAILURES"
