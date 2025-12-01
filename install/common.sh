#!/usr/bin/env bash
set -e

BREWFILE="$HOME/.dotfiles/brew/Brewfile"

if [ -f "$BREWFILE" ]; then
  echo "Running Brewfile..."
  brew bundle --file="$BREWFILE"
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
