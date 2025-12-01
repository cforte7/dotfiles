#!/usr/bin/env bash
set -e
printf "Running linux.sh\n"
sudo apt-get update
sudo apt-get install -y build-essential

set -e
if ! command -v brew >/dev/null; then
  echo "Installing Homebrew from linux.sh"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo >>/home/ubuntu/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/ubuntu/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
