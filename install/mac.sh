#!/usr/bin/env bash
if ! command -v brew >/dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREWFILE="$HOME/dotfiles/brew/Brewfile"

if [ -f "$BREWFILE" ]; then
  printf "Running Brewfile..."
  brew bundle --file="$BREWFILE"
fi
printf "Brewfile complete\n\n"