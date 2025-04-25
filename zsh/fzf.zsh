#!/usr/bin/env zsh

source /usr/share/fzf/key-bindings.zsh

# Rebind ALT-c to CTRL-e
bindkey -rM emacs '\ec'
bindkey -rM vicmd '\ec'
bindkey -rM viins '\ec'

zle     -N              fzf-cd-widget
bindkey -M emacs '\C-e' fzf-cd-widget
bindkey -M vicmd '\C-e' fzf-cd-widget
bindkey -M viins '\C-e' fzf-cd-widget

source /usr/share/fzf/completion.zsh

source $DOTFILES/zsh/scripts_fzf.zsh # fzf Scripts
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           find . -type d | fzf --preview 'tree -C {}' "$@";;
        *)            fzf "$@" ;;
    esac
}

_fzf_compgen_path() {
    rg --files --glob "!.git" "$1"
}

_fzf_compgen_dir() {
   fd --type d --hidden --follow --exclude ".git" "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    tree)         find . -type d | fzf --preview 'tree -C {}' "$@";;
    *)            fzf "$@" ;;
  esac
}

# pacf: Fuzzy finder for pacman packages (official repos)
fpac() {
  local installed pkg_info pkg
  installed=$(pacman -Qq)

  pkg_info=$(
    fzf \
      --ansi \
      --ignore-case \
      --header="Search packages" \
      --bind "change:reload(if [ '{q}' != '' ]; then pacman -Ss {q} | awk '/^[^[:space:]]+\\// {print \$1,\$2}' | while IFS= read -r line; do pkg=\$(echo \"\$line\" | awk '{print \$1}' | cut -d'/' -f2); if echo \"$installed\" | grep -iwq \"\$pkg\"; then echo \"\$line \x1b[1;32m(Installed)\x1b[0m\"; else echo \"\$line\"; fi; done; else echo ''; fi)" \
      --query "" \
      --preview 'pkg=$(echo {} | awk "{print \$1}" | cut -d"/" -f2); pacman -Si "$pkg" 2>/dev/null | sed -r \
        -e "s/^(Repository[[:space:]]*:)/\x1b[38;2;116;199;236m\1\x1b[0m/" \
        -e "s/^(Name[[:space:]]*:)/\x1b[38;2;203;166;247m\1\x1b[0m/" \
        -e "s/^(Version[[:space:]]*:)/\x1b[38;2;137;180;250m\1\x1b[0m/" \
        -e "s/^(Description[[:space:]]*:)/\x1b[38;2;166;227;161m\1\x1b[0m/" \
        -e "s/^(Architecture[[:space:]]*:)/\x1b[38;2;250;179;135m\1\x1b[0m/" \
        -e "s/^(URL[[:space:]]*:)/\x1b[38;2;148;226;213m\1\x1b[0m/" \
        -e "s/^(Licenses[[:space:]]*:)/\x1b[38;2;242;205;205m\1\x1b[0m/" \
        -e "s/^(Groups[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Provides[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Depends On[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Optional Deps[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Required By[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/"' \
      --preview-window="right:60%" \
      --color='fg:#cdd6f4,bg:#1e1e2e,hl:#cba6f7,fg+:#cdd6f4,bg+:#313244,hl+:#cba6f7,pointer:#f38ba8,marker:#fab387,spinner:#f38ba8,header:#cba6f7,info:#94e2d5,prompt:#a6e3a1,query:#a6e3a1'
  )

  if [ -n "$pkg_info" ]; then
    pkg=$(echo "$pkg_info" | awk '{print $1}' | cut -d'/' -f2)
    if echo "$pkg_info" | grep -qi "(Installed)"; then
      echo "Package '$pkg' is already installed."
    else
      echo "Installing package: $pkg"
      sudo pacman -S "$pkg"
    fi
  fi
}

# yayf: Fuzzy finder for yay packages (official repos + AUR)
fyay() {
  local installed pkg_info pkg
  installed=$(pacman -Qq)

  pkg_info=$(
    fzf \
      --ansi \
      --ignore-case \
      --header="Search packages" \
      --bind "resize:reload()" \
      --bind "change:reload(if [ '{q}' != '' ]; then yay -Ss {q} | awk '/^[^[:space:]]+\\// {print \$1,\$2}'; else echo ''; fi)" \
      --query "" \
      --preview 'pkg=$(echo {} | awk "{print \$1}" | cut -d"/" -f2); yay -Si "$pkg" 2>/dev/null | sed -r \
        -e "s/^(Repository[[:space:]]*:)/\x1b[38;2;116;199;236m\1\x1b[0m/" \
        -e "s/^(Name[[:space:]]*:)/\x1b[38;2;203;166;247m\1\x1b[0m/" \
        -e "s/^(Version[[:space:]]*:)/\x1b[38;2;137;180;250m\1\x1b[0m/" \
        -e "s/^(Description[[:space:]]*:)/\x1b[38;2;166;227;161m\1\x1b[0m/" \
        -e "s/^(Architecture[[:space:]]*:)/\x1b[38;2;250;179;135m\1\x1b[0m/" \
        -e "s/^(URL[[:space:]]*:)/\x1b[38;2;148;226;213m\1\x1b[0m/" \
        -e "s/^(Licenses[[:space:]]*:)/\x1b[38;2;242;205;205m\1\x1b[0m/" \
        -e "s/^(Groups[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Provides[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Depends On[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Optional Deps[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/" \
        -e "s/^(Required By[[:space:]]*:)/\x1b[38;2;137;220;235m\1\x1b[0m/"' \
      --preview-window="right:60%" \
      --color='fg:#cdd6f4,bg:#1e1e2e,hl:#cba6f7,fg+:#cdd6f4,bg+:#313244,hl+:#cba6f7,pointer:#f38ba8,marker:#fab387,spinner:#f38ba8,header:#cba6f7,info:#94e2d5,prompt:#a6e3a1,query:#a6e3a1'
  )

  if [ -n "$pkg_info" ]; then
    pkg=$(echo "$pkg_info" | awk '{print $1}' | cut -d'/' -f2)
    echo "Installing package: $pkg"
    yay -S "$pkg"
  fi
}

