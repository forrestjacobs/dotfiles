#!/usr/bin/env bash
set -euo pipefail

case "${1:-}" in
  description)
    describe
    ;;

  check)
    check
    ;;

  *)
    if check; then
      read -p "Set up $(describe)? " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        fix
      fi
    fi
    ;;
esac
