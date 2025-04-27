#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"
SYSTEM_ZSHENV="/etc/zsh/zshenv"

echo "Configuring ZDOTDIR..."

# Add ZDOTDIR to /etc/zsh/zshenv if not already present
if grep -q "ZDOTDIR" "$SYSTEM_ZSHENV" 2>/dev/null; then
  echo "ZDOTDIR already set in $SYSTEM_ZSHENV"
else
  echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a "$SYSTEM_ZSHENV"
  echo "Added ZDOTDIR to $SYSTEM_ZSHENV"
fi

echo "Stowing dotfiles to ~/.config"
stow .

echo "Setting up Zsh plugins in $ZSH_PLUGIN_DIR"
mkdir -p "$ZSH_PLUGIN_DIR"

declare -A plugins=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
  ["zsh-history-substring-search"]="https://github.com/zsh-users/zsh-history-substring-search"
  ["fizsh"]="https://github.com/zsh-users/fizsh"
  ["zaw"]="https://github.com/zsh-users/zaw"
)

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
