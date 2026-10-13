#!/usr/bin/env sh

: "${shell:?}"

p_abbr () {
  if test "${shell}" = fish; then
    echo "abbr $1 \"$2\""
  else
    echo "alias $1=\"$2\""
  fi
}

p_export () {
  if test "${shell}" = fish; then
    echo "set -gx $1 \"$2\""
  else
    echo "export $1=\"$2\""
  fi
}

cache_path="\$HOME/.cache/dotfiles/$shell"
if test "${shell}" = fish; then
  echo "set -l cache_path \"$cache_path\""
  echo "test -d \"\$cache_path\"; or mkdir -p \"\$cache_path\""
else
  echo "cache_path=\"$cache_path\""
  echo "test -d \"\$cache_path\" || mkdir -p \"\$cache_path\""
fi

p_source () {
  file_path="\$cache_path/${1##*/}"
  if test "${shell}" = fish; then
    echo "if set -l cmd_path (command -v \"$1\")"
    echo "  test \"\$cmd_path\" -ot \"$file_path\"; or $* > \"$file_path\""
    echo "  source \"$file_path\""
    echo "end"
  else
    echo "if cmd_path=\$(command -v \"$1\"); then"
    echo "  [[ \"\$cmd_path\" -ot \"$file_path\" ]] || $* > \"$file_path\""
    echo "  . \"$file_path\""
    echo "fi"
  fi
}

add_path () {
  if test "${shell}" = fish; then
    echo "fish_add_path --path \"$1\""
  else
    echo "[[ \":\$PATH:\" == *\":$1:\"* ]] || export PATH=\"$1:\$PATH\""
  fi
}

p_export XDG_CONFIG_HOME \$HOME/.config
add_path \$HOME/.local/bin

# Homebrew
if test "$(uname)" = Darwin; then
  brew_prefix=/opt/homebrew
else
  brew_prefix=/home/linuxbrew/.linuxbrew
fi

p_source $brew_prefix/bin/brew shellenv "$shell"
