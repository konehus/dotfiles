#!/usr/bin/env zsh

fpath=($DOTFILES/zsh/plugins $fpath)

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

source $DOTFILES/zsh/plugins/bd.zsh

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# +--------+
# | COLORS |
# +--------+

# Override colors
eval "$(dircolors -b $ZDOTDIR/dircolors)"

# +---------+
# | ALIASES |
# +---------+

source $DOTFILES/aliases/aliases

# +---------+
# | SCRIPTS |
# +---------+

source $DOTFILES/zsh/scripts.zsh
if [ -e "$DOTFILES_CLOUD/scripts.zsh" ]; then
    source $DOTFILES_CLOUD/scripts.zsh
fi

source "$DOTFILES/zsh/plugins/fg_bg.sh"
zle -N fg-bg
bindkey '^Z' fg-bg

function _new_command {
    zle push-input
    BUFFER=""
}

zle -N _new_command
bindkey '^Xo' _new_command

# +--------------------+
# | TIME NOTIFICATIONS |
# +--------------------+

# Send notification when command line done
source $DOTFILES/zsh/plugins/notifyosd.zsh

# +--------+
# | PROMPT |
# +--------+
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# +-----------+
# | PROFILING |
# +-----------+

zmodload zsh/zprof

# +-----------+
# | VI KEYMAP |
# +-----------+

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor
source "$DOTFILES/zsh/plugins/cursor_mode"

# Add Vi text-objects for brackets and quotes
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Emulation of vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Increment a number
autoload -Uz incarg
zle -N incarg
bindkey -M vicmd '^a' incarg

# +------------+
# | COMPLETION |
# +------------+

source $DOTFILES/zsh/completion.zsh
autoload -Uz $DOTFILES/zsh/plugins/kubectl-completion/zsh-kubectl-completion

# +-----+
# | Git |
# +-----+

# Add command gitit to open Github repo in default browser from a local repo
source $DOTFILES/zsh/plugins/gitit.zsh

# +-----+
# | FZF |
# +-----+

if [ $(command -v "fzf") ]; then
    source $DOTFILES/zsh/fzf.zsh
fi

# +---------+
# | Startup |
# +---------+


# +---------+
# | BINDING |
# +---------+

# ctrl+l used for tmux (switch pane)
# bindkey -r '^l'
# bindkey -r '^g'
# bindkey '^g' .clear-screen

# bindkey -r '^p'
# bindkey -s '^p' 'fpdf\n'

# bindkey -s '^b' 'go run .\n'

# edit current command line with vim (vim-mode, then CTRL-v)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

source "$DOTFILES/zsh/bindings.zsh"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 0 

plugins=(git aws colored-man-pages colorize command-not-found extract
	  fzf last-working-dir sdk spring sudo zoxide 
	 zsh-interactive-cd web-search 
	 zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# VIM
alias v="/usr/bin/nvim"
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

#chatgpt allias 
alias gpt='chatgpt'
