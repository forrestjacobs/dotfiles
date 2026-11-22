#!/usr/bin/env bash
set -euo pipefail

describe() {
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "Touch ID sudo"
  else
    echo "passwordless sudo"
  fi
}

check() {
  if [[ "$(uname)" == "Darwin" ]]; then
    [ -f /etc/pam.d/sudo_local ]
  else
    [[ $(sudo -nl) = *"NOPASSWD: ALL"* ]]
  fi
}

fix() {
  # Set up Touch ID sudo on Darwin
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "auth sufficient pam_tid.so" | sudo tee "/etc/pam.d/sudo_local"
    exit
  else
    sudo mkdir -p "/etc/sudoers.d"
    echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/50-nopasswd"
    exit
  fi
}
