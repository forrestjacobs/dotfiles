#!/usr/bin/env bash

escape () {
  local text=$1
  text=${text//\\/\\\\}
  text=${text//\'/\\\'}
  echo "'$text'"
}

p_alias () {
  echo "alias $(escape "$1")=$(escape "$2")"
}

p_abbr () {
  if [[ "${shell:?}" = "fish" ]]; then
    echo "abbr $(escape "$1") $(escape "$2")"
  else
    p_alias "$@"
  fi
}

p_export () {
  export "$1"="$2"
  echo "export $(escape "$1")=$(escape "$2")"
}

add_path () {
  if ! echo "$PATH" | grep -E -q "(^|:)$1($|:)" ; then
    p_export PATH "$1:$PATH"
  fi
}

p_export XDG_CONFIG_HOME "$HOME"/.config
add_path "$HOME"/.local/bin

# Homebrew
if ! has brew; then
  for brew_path in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if has "$brew_path"; then
      $brew_path shellenv "${shell:?}"
      eval "$($brew_path shellenv bash)"
      break
    fi
  done
fi
