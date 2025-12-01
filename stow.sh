#!/usr/bin/env bash
set -e

cd "$HOME/.dotfiles"

# List of stow packages
PACKAGES=(
  zsh
)

for pkg in "${PACKAGES[@]}"; do
  echo "Stowing $pkg"
  stow --target="$HOME" "$pkg"
done
