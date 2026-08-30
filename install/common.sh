#!/usr/bin/env bash
set -e

printf "Starting Common\n"

# Basic check and remove
if [ -d ~/.oh-my-zsh ]; then
  printf "Removing oh-my-zsh\n"
  rm -rf ~/.oh-my-zsh
fi

printf "Adding ohmyzsh\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_zsh_plugin() {
  local name="$1"
  local repository="$2"
  local destination="$ZSH_CUSTOM_DIR/plugins/$name"

  if [ -d "$destination" ]; then
    printf "%s is already installed\n" "$name"
    return
  fi

  printf "Adding %s\n" "$name"
  git clone --depth=1 "$repository" "$destination"
}

printf "Adding PL10K\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM_DIR/themes/powerlevel10k"

install_zsh_plugin \
  zsh-npm-scripts-autocomplete \
  https://github.com/grigorii-zander/zsh-npm-scripts-autocomplete.git
install_zsh_plugin \
  zsh-autosuggestions \
  https://github.com/zsh-users/zsh-autosuggestions.git
install_zsh_plugin \
  zsh-syntax-highlighting \
  https://github.com/zsh-users/zsh-syntax-highlighting.git


if command -v omp >/dev/null 2>&1; then
  printf "omp is already installed. Skipping...\n"
else
  printf "Installing omp\n"
  curl -fsSL https://omp.sh/install | sh
fi

printf "End of common\n\n"
