#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"

START="$(pwd)"
# Remove existing ~/.dotfiles if it exists
[ -d ~/dotfiles ] && rm -rf ~/dotfiles

# Copy current directory to ~/dotfiles
cp -r . ~/dotfiles
cd ~/dotfiles

# Detect OS
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
  bash install/mac.sh
else
  bash install/linux.sh
fi

# Install common packages
printf "Running common.sh\n\n"
bash install/common.sh

bash stow.sh

cd $START
echo "✔ Done. Restart your shell."
