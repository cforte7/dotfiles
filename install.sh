#!/usr/bin/env bash
set -e

REPO="$HOME/.dotfiles"

if [ ! -d "$REPO" ]; then
  git clone https://github.com/cforte7/dotfiles.git "$REPO"
fi

cd "$REPO"

# Detect OS
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
  ./install/mac.sh
else
  ./install/linux.sh
fi

# Install common packages
./install/common.sh

./stow.sh

echo "✔ Done. Restart your shell."
