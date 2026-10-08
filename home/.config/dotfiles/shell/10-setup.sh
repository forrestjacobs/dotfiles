#!/usr/bin/env bash

: "${shell:?}"

# Inlining for performance
has () {
  command -v "$1" &> /dev/null
}

p_alias () {
  if [[ "${shell}" = "fish" ]]; then
    printf "function %q --wraps=%q --description %q\n    %s\nend\n" "$1" "$2" "$2" "$2"
  else
    printf "alias %q=%q\n" "$1" "$2"
  fi
}

p_abbr () {
  if [[ "${shell}" = "fish" ]]; then
    printf "abbr %q %q\n" "$1" "$2"
  else
    p_alias "$@"
  fi
}

p_export () {
  export "$1"="$2"
  if [[ "${shell}" = "fish" ]]; then
    printf "set -gx %q %q\n" "$1" "$2"
  else
    printf "export %q=%q\n" "$1" "$2"
  fi
}

add_path () {
  if ! [[ ":$PATH:" == *":$1:"* ]]; then
    p_export PATH "$1:$PATH"
  fi
}

p_export XDG_CONFIG_HOME "$HOME"/.config
add_path "$HOME"/.local/bin

# Homebrew
if ! has brew; then
  for brew_path in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if has "$brew_path"; then
      $brew_path shellenv "${shell}"
      eval "$($brew_path shellenv bash)"
      break
    fi
  done
fi
