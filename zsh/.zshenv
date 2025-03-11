#!/usr/bin/env zsh

# ~/.zshenv - Global environment configuration
# This file sets essential environment variables, paths, locale settings, 
# and history confisl;dfj;klsadfsfgurations. It is sourced for all Zsh sessions, 
# including login, non-login, and script executions.

# Personal environment variables
export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"

# Set user-specific environment variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Preferred locale settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIR="$HOME/.config}"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME/usr/local/share:/usr/share"
export XDG_STATE_HOME="$HOME/.local/state}"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
export LESSHISTFILE=${LESSHISTFILE:-/tmp/less-hist}
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
# wget
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# Ensure Zsh is the default shell
export SHELL=$(command -v zsh)

# Other Software
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
export ZSH="$HOME/.config/oh-my-zsh"

# Man Pages
export MANPAGER='nvim +Man!'

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# Changing Display mode  < https://vitormv.github.io/fzf-themes/ >
export FZF_COLORS="
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#3e324d
  --color=hl:#ed8796,hl+:#5fd7ff,info:#d4c1ea,marker:#b7bdf8
  --color=prompt:#c6a0f6,spinner:#f4dbd6,pointer:#f4dbd6,header:#ed8796
  --color=border:#4c3d5e,separator:#c6a0f6,label:#cad3f5,query:#d9d9d9 "

export FZF_DEFAULT_OPTS="--height 60% \
--border sharp \
--layout reverse \
$FZF_COLORS \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"

# golang
export GOPATH="$WORKSPACE/go"
export GOBIN="$WORKSPACE/go/bin"
export GOCACHE="$XDG_CACHE_HOME/go-build"

# #Set paths (prepend custom paths to ensure priority)
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
