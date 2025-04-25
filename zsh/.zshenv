#!/usr/bin/env zsh

# ~/.zshenv - Global environment configuration
# This file sets essential environment variables, paths, locale settings, 
# and history configuration is sourced for all Zsh sessions, 
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
export XDG_CONFIG_DIR="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/.local/share:/usr/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
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

# #Set paths (prepend custom paths to ensure priority)
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

#bat
# export BAT_CONFIG_DIR="$XDG_CONFIG_DIR/bat"
# export BAT_CONFIG_PATH="$BAT_CONFIG_DIR/bat.conf"
# export BAT_THEME='Catppuccin Mocha'

# JDK versions
export JDK24="/usr/lib/jvm/java-24-openjdk"
export JDK21="/usr/lib/jvm/java-21-openjdk"
export JDK17="/usr/lib/jvm/java-17-openjdk"
export JDK8="/usr/lib/jvm/java-8-openjdk"
export JDK21_SRC="$JDK21/lib/src.zip"

