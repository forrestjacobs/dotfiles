#!/bin/sh
set -eu

if test -z "$CODESPACES" && test -z "$REMOTE_CONTAINERS"; then
  echo "Only intended for Dev Containers and GitHub Codespaces" 1>&2
  exit 1
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends chezmoi
exec chezmoi init --apply --source="${HOME}"/dotfiles
