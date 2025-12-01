#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
filter="$1"
cd "$script_dir" || exit
scripts=$(find ./runs -maxdepth 1 -mindepth 1 -type f)
for script in $scripts; do
  echo "$script"
  if echo "$script" | grep -qv "$filter"; then
    continue
  fi
  "$script"
done

# Homebrew
# /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install $(cat brew_install.txt)

#

# Python
# /bin/zsh curl -LsSf https://astral.sh/uv/install.sh | sh

# Rust

# Go
