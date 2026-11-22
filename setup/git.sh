#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "git config"
}

check() {
  git config --global user.name
  git config --global user.email
  [[ $(git config --global init.defaultBranch) = "main" ]]
  [[ $(git config --global pull.ff) = "only" ]]
}

git_config_nice() {
  if ! git config --global "$1"; then
    git config --global "$1" "$2"
  fi
}

fix() {
  git_config_nice user.name "Forrest Jacobs"
  git_config_nice user.email forrestjacobs@gmail.com
  git config --global init.defaultBranch main
  git config --global pull.ff only
}
