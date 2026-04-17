#!/usr/bin/env bash
set -e
printf "Running linux.sh\n"
sudo apt-get update
printf "Running build-essential\n\n"
sudo apt-get install -y build-essential
printf "Installing stow\n\n"
sudo apt install stow

# if ! command -v brew >/dev/null; then
#   echo "Installing Homebrew from linux.sh\n\n"
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#   eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# fi

