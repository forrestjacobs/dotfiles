#!/usr/bin/env bash
set -euo pipefail

describe() {
  echo "Homebrew Autoupdate"
}

check() {
  if has launchctl; then
    launchctl list | grep -q "com.github.domt4.homebrew-autoupdate"
  fi
}

fix() {
  dot_setup_brew
  brew autoupdate start --cleanup --immediate
}
