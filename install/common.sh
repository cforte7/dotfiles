#!/usr/bin/env zsh 
set -e

printf "Starting Common\n"
BREWFILE="$HOME/dotfiles/brew/Brewfile"

if [ -f "$BREWFILE" ]; then
  printf "Running Brewfile..."
  brew bundle --file="$BREWFILE"
fi
printf "Brewfile complete\n\n"

# Basic check and remove
if [ -d ~/.oh-my-zsh ]; then
  printf "Removing oh-my-zsh\n"
  rm -rf ~/.oh-my-zsh
fi

printf "Adding ohmyzsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

printf "adding PL10K\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
printf "End of common\n\n"
