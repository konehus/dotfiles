#!/usr/bin/env zsh

#############################################################################
##### ──────────────── fzf key-binding setup ──────────────── #####
source /usr/share/fzf/key-bindings.zsh
for map in emacs vicmd viins; do
  bindkey -rM $map '\ec'          # unbind default Alt-c
  bindkey -M $map '^e' fzf-cd-widget
done

##### ──────────────── archive helpers ──────────────── #####
_ex() {
  case $1 in
    *.tar.bz2|*.tbz2) tar xjf "$1" ;;
    *.tar.gz|*.tgz)   tar xzf "$1" ;;
    *.tar.xz|*.txz)   tar xJf "$1" ;;
    *.bz2)            bunzip2 "$1" ;;
    *.gz)             gunzip  "$1" ;;
    *.xz)             unxz    "$1" ;;
    *.tar)            tar xf  "$1" ;;
    *.zip)            unzip   "$1" ;;
    *.7z|*.rar|*.iso) 7z x    "$1" ;;
    *.Z)              uncompress "$1" ;;
    *) echo "'$1' cannot be extracted" ;;
  esac
}

extract()   { for f in "$@"; do [[ -f $f ]] && _ex "$f" || echo "'$f' not a file"; done }

mkextract() {
  for f in "$@"; do
    [[ -f $f ]] || { echo "'$f' not a file"; continue; }
    local d=${f%.*}
    mkdir -p "$d" && cp "$f" "$d/" &&
      (cd "$d" && _ex "${f:t}" && rm -f "${f:t}")
  done
}

compress()  { tar cvzf "$(date +%Y%m%d-%H%M%S).tar.gz" "$@"; }

fwork() {
  local d
  d=$(find ~/workspace -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort | fzf)
  [[ -n $d ]] && cd ~/workspace/$d
}

##### ──────────────── man-page fuzzy search ──────────────── #####
fman() {
  local sel page sec
  sel=$(man -k . | sort -u | fzf --prompt='man> ' \
        --preview='echo {} | awk "{print \$1}" | xargs -r man --pager=cat | col -bx | head -100')
  [[ -z $sel ]] && return
  page=$(awk '{print $1}' <<< "$sel")
  sec=$(sed -n 's/.*(\([0-9A-Za-z]\+\)).*/\1/p' <<< "$sel")
  man ${sec:-1} "$page"
}

##### ──────────────── SSH key / disk / mount helpers ──────────────── #####
ssh-create() {
  local name=$1; [[ $name ]] || { echo "usage: ssh-create <keyname>"; return 1; }
  local key="$HOME/.ssh/$name"
  ssh-keygen -f "$key" -t rsa -N '' -C "$name" &&
  chmod 600 "$key" && chmod 644 "$key.pub"
}

mnt()     { local dir=${2:-/mnt/external}; [[ $1 ]] && sudo mount "$1" "$dir" -o rw || echo "usage: mnt <device> [mountpoint]"; }
umnt()    { local dir=${1:-/mnt}; sudo umount $(grep " $dir " /proc/mounts | cut -d' ' -f2); }
mntmtp()  { local dir=${2:-$HOME/mnt}; [[ -d $dir ]] || mkdir -p "$dir"; [[ $1 ]] && simple-mtpfs --device "$1" "$dir" || echo "usage: mntmtp <devnum> [mountpoint]"; }
umntmtp() { umount "${1:-$HOME/mnt}"; }

##### ──────────────── PostgreSQL helpers ──────────────── #####
postgdump() {
  local db=$1 user=${2:-postgres} host=${3:-localhost}; [[ $db ]] || { echo "usage: postgdump <db> [user] [host]"; return 1; }
  [[ -f "$db.sql" ]] && rm -i "$db.sql"
  pg_dump -c -U "$user" -h "$host" "$db" | pv > "$db.sql"
}

postgimport() {
  local sql=$1 user=${2:-postgres} host=${3:-localhost}; [[ $sql ]] || { echo "usage: postgimport <file.sql> [user] [host]"; return 1; }
  local db=${sql%.*}
  pv "$sql" | psql -U "$user" -h "$host" -d "$db"
}

pgdump() { pg_dump -U postgres -h localhost x_loc_0bdf08de > pulsecheck_service_test.sql; }  # sample helper

##### ──────────────── misc: quick password generator ──────────────── #####
autopass() { < /dev/urandom tr -dc 'A-Za-z0-9!@#%^&*()_+=' | head -c${1:-20}; echo; }


fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [[ -n $cwd && $cwd != $PWD ]]; then
    cd "$cwd"
  fi
  rm -f "$tmp"
}
