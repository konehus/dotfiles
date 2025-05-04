#!/usr/bin/env zsh

# Core Options
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt CORRECT CDABLE_VARS EXTENDED_GLOB
setopt EXTENDED_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY

# Sources / Paths
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases/aliases"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/scripts.zsh"

# Plugin paths
ZSH_PLUGIN_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins"
fpath=("$ZSH_PLUGIN_DIR/zsh-completions/src" $fpath)

# Prompt
export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# FZF / BAT
export MANPAGER=$'sh -c \'sed -u -e "s/\\x1B\\[[0-9;]*m//g; s/.\\x08//g" | bat -p -lman\''
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_OPTS=$'--preview \'(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200\''
FZF_COLORS=$'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#3e324d
  --color=hl:#ed8796,hl+:#5fd7ff,info:#d4c1ea,marker:#b7bdf8
  --color=prompt:#c6a0f6,spinner:#f4dbd6,pointer:#f4dbd6,header:#ed8796
  --color=border:#4c3d5e,separator:#c6a0f6,label:#cad3f5,query:#d9d9d9 '
export FZF_DEFAULT_OPTS="--height 60% --border sharp --layout reverse $FZF_COLORS --prompt '∷ ' --pointer ▶ --marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"


# Key Bindings
bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

autoload -Uz select-bracketed select-quoted
zle -N select-quoted select-quoted
zle -N select-bracketed select-bracketed

# Plugins
[[ -f "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
autoload -Uz compinit && compinit
[[ -f "$ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh" ]] && source "$ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"
[[ -f "$ZSH_PLUGIN_DIR/zaw/zaw.zsh" ]] && source "$ZSH_PLUGIN_DIR/zaw/zaw.zsh"


# zsh-autosuggestions -- common key-bindings
# Accept the current suggestion
bindkey '^F' autosuggest-accept        # Ctrl-F
bindkey -M viins '^F' autosuggest-accept
bindkey '^E' autosuggest-execute       # Ctrl-E  (end & execute)
bindkey '^K' autosuggest-clear         # Ctrl-K
bindkey '^T'  autosuggest-toggle       # Ctrl-T  (single stroke)

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Vim Surround Emulation
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround


unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Environment
export JDK24="/usr/lib/jvm/java-24-openjdk"
export JDK21="/usr/lib/jvm/java-21-openjdk"
export JDK17="/usr/lib/jvm/java-17-openjdk"
export JDK8="/usr/lib/jvm/java-8-openjdk"
export JDK21_SRC="$JDK21/lib/src.zip"
alias mvn="mvn -gs $XDG_CONFIG_HOME/maven/settings.xml"
