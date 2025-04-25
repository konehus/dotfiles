#!/usr/bin/env zsh

# ==============================
#          FILE PATHS
# ==============================
fpath=($DOTFILES/zsh/plugins $fpath)

# ==============================
#        NAVIGATION SETTINGS
# ==============================
setopt AUTO_CD              # Change directory without `cd`
setopt AUTO_PUSHD           # Push old directory onto stack on `cd`
setopt PUSHD_IGNORE_DUPS    # Ignore duplicate directories in stack
setopt PUSHD_SILENT         # Suppress directory stack printout
setopt CORRECT              # Enable spelling correction for commands
setopt CDABLE_VARS          # Allow `cd` into a path stored in a variable
setopt EXTENDED_GLOB        # Enable extended globbing syntax

# ==============================
#        HISTORY SETTINGS
# ==============================
setopt EXTENDED_HISTORY          # Save history in `:start:elapsed;command` format
setopt SHARE_HISTORY             # Share history across all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Remove oldest duplicate first
setopt HIST_IGNORE_DUPS          # Ignore consecutive duplicate commands
setopt HIST_IGNORE_ALL_DUPS      # Remove all duplicates from history
setopt HIST_FIND_NO_DUPS         # Ignore duplicates when searching history
setopt HIST_IGNORE_SPACE         # Ignore commands starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate commands to history
setopt HIST_VERIFY               # Require confirmation before executing expanded history command

# ==============================
#          ALIASES
# ==============================
source $DOTFILES/aliases/aliases

# ==============================
#          SCRIPTS
# ==============================
source $DOTFILES/zsh/scripts.zsh

# ==============================
#           PROMPT
# ==============================
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# ==============================
#        COMPLETION
# ==============================
source $DOTFILES/zsh/completion.zsh

# ==============================
#          FZF (Fuzzy Finder)
# ==============================
# if [ $(command -v "fzf") ]; then
#     source $DOTFILES/zsh/fzf.zsh
# fi
# Man Pages
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
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

# ==============================
#      EDITING COMMAND LINE
# ==============================
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# ==============================
#       VIM-LIKE NAVIGATION
# ==============================
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# ==============================
#       DIRENV SUPPORT
# ==============================
# eval "$(direnv hook zsh)"

# ==============================
#         VI KEYMAPS
# ==============================
bindkey -v              # Enable Vi mode

# ==============================
#     VI TEXT OBJECTS (Quotes & Brackets)
# ==============================
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

# ==============================
#        VIM-SURROUND EMULATION
# ==============================
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# ==============================
#     AUTO-SUGGESTIONS & HIGHLIGHTING
# ==============================
bindkey '^@' autosuggest-accept
source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
export GITHUB_TOKEN=$(secret-tool lookup service github username konehus)
