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
export PATH="$HOME/.local/bin:$XDG_DATA_HOME/npm/bin:$PATH"

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
export MAVEN_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/maven"         # where settings.xml will sit
export NPM_CONFIG_INIT_MODULE="${XDG_CONFIG_HOME:-$HOME/.config}/npm/config/npm-init.js"
export NPM_CONFIG_TMP="${XDG_CONFIG_HOME:-$HOME/.config}/npm"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export BAT_CONFIG_PATH="$BAT_CONFIG_DIR/bat.conf"

export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nv"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"


export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/shares}/pass"
export PASSWORD_STORE_TOMB_FILE="${XDG_DATA_HOME:-$HOME/.local/shares}/pass-tomb/.password.tomb"
export PASSWORD_STORE_TOMB_KEY="${XDG_DATA_HOME:-$HOME/.local/shares}/pass-tomb/.password.tomb.key"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/shares}/gnupg"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/shares}/go"
export GRADLE_USER_HOME="${XDG_DATA_HOME:-$HOME/.local/shares}/gradle"
export MAVEN_USER_HOME="${XDG_DATA_HOME:-$HOME/.local/shares}/maven"        # binaries + wrapper cache
export PYTHON_HISTORY="${XDG_DATA_HOME:-$HOME/.local/shares}/python/history"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/shares}/rustup"

# Personal environment variables
export WORKSPACE="$HOME/workspace"
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/bash/history"

# Ensure Zsh is the default shell
export SHELL=$(command -v zsh)
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
