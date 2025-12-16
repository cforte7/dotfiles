#!/bin/bash

# List of directories to stow
DOTFILES_DIR="$HOME/dotfiles"
STOW_DIRS=("zsh" "tmux") # Add your directories here

cd "$DOTFILES_DIR"
for dir in "${STOW_DIRS[@]}"; do
  echo "Processing $dir..."

  if [ -d "$dir" ]; then
    find "$dir" -type f | while read -r file; do
      # Use sed or parameter expansion to remove the dir prefix
      relative_path=$(echo "$file" | sed "s|^$dir/||")
      target="$HOME/$relative_path"

      if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "  Removing existing file: $target"
        rm -f "$target"
      fi
    done

    stow -R "$dir"
    echo "  ✓ Stowed $dir"
  fi
done
echo "Done!"
