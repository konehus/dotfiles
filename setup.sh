#!/usr/bin/env bash

set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Function to stow a directory
stow_dir() {
  local dir="$1"
  local target="$2"

  echo "Stowing $dir to $target"
  stow --dir="$DOTFILES_DIR" --target="$target" --restow "$dir"
}

# 1. Stow .zshenv to $HOME
stow_dir "zsh" "$HOME"

# 2. Stow config/ to ~/.config/
stow_dir "config" "$HOME/.config"

# 3. Setup Zsh plugins
echo "Setting up Zsh plugins in $ZSH_PLUGIN_DIR"

# Ensure plugin directory exists
mkdir -p "$ZSH_PLUGIN_DIR"

# Define plugin list
declare -A plugins=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
  ["zsh-history-substring-search"]="https://github.com/zsh-users/zsh-history-substring-search"
  ["fizsh"]="https://github.com/zsh-users/fizsh"
  ["zaw"]="https://github.com/zsh-users/zaw"
)

# Clone or update each plugin
for name in "${!plugins[@]}"; do
  repo="${plugins[$name]}"
  dest="$ZSH_PLUGIN_DIR/$name"

  if [ -d "$dest/.git" ]; then
    echo "Updating $name..."
    git -C "$dest" pull --ff-only
  else
    echo "Cloning $name..."
    rm -rf "$dest"
    git clone "$repo" "$dest"
  fi
done

echo "Dotfiles and Zsh plugins setup complete!"
