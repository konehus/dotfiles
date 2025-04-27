#!/usr/bin/env zsh

# XDG base directories ( https://specifications.freedesktop.org/basedir-spec/latest/ )
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export XDG_RUNTIME_DIR="/run/user/${UID}"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="$XDG_CONFIG_DIRS:/etc/xdg:/usr/local/etc/xdg"

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"

#Set paths (prepend custom paths to ensure priority)
export PATH="$HOME/.local/bin:$PATH"

# Set user-specific environment variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Config based on xdg
export PARALLEL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/parallel"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wgetrc"
export SCREENRC="${XDG_CONFIG_HOME:-$HOME/.config}/screen/screenrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export VIMCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
export BAT_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bat"
export BAT_CONFIG_PATH="$BAT_CONFIG_DIR/bat.conf"

export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/shares}/gnupg"

# Personal environment variables
export WORKSPACE="$HOME/workspace"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath

# Ensure Zsh is the default shell
export SHELL=$(command -v zsh)
