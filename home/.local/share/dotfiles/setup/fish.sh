#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "fish shell"
}

check() {
  [ "$(basename "$SHELL")" = "fish" ]
}

fix() {
  if has lsb_release && [[ "$(lsb_release -is)" == "Debian" ]] && (( "$(lsb_release -rs)" >= 12 )); then
    sudo DEBIAN_FRONTEND=noninteractive apt-get update --yes
    sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends fish
  fi

  if ! has fish; then
    echo "install fish and then try again"
    exit 1
  fi

  fish_path="$(type -P fish)"
  if ! grep -q -F "${fish_path}" /etc/shells; then
    echo "Adding ${fish_path} to /etc/shells"
    echo "${fish_path}" | sudo tee -a /etc/shells
  fi
  echo "Changing shell to ${fish_path}"
  sudo chsh -s "${fish_path}" "$USER"
}
