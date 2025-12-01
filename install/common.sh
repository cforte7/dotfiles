set -e
if ! command -v brew >/dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREWFILE="$HOME/.dotfiles/brew/Brewfile"

if [ -f "$BREWFILE" ]; then
  echo "Running Brewfile..."
  brew bundle --file="$BREWFILE"
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
