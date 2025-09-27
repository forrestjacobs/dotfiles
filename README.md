# Forrest's dotfiles

This repository contains scripts and config files for my Mac & Linux development environments. Running `install.sh` installs [my config files](./home), adds [my scripts](./home/.local/bin) to `$PATH`, and installs [some packages](./home/.config/homebrew/Brewfile) via [Homebrew](https://brew.sh/). It supports [fish](https://fishshell.com/), [bash](https://www.gnu.org/software/bash/), and [zsh](https://www.zsh.org/) by sourcing in the output of [`dot_shell [fish|bash|zsh]`](./home/.local/bin/dot_shell).

## Used on

- Recent macOS
- Debian 12+ (both as a host and in a dev container)
- Recent NixOS via [Home Manager](https://nix-community.github.io/home-manager/)

## Setup

### Mac or Linux

1. Install [Homebrew](https://brew.sh/). (Optional but recommended.)
2. Install and set up the [GitHub CLI](https://cli.github.com/). (Also optional but recommended.)
   ```bash
   brew install gh
   gh auth login
   gh auth setup-git
   ```
3. Check out this project and run `./install.sh`.

There may be additional instructions printed at the end of the script's output. Run `dot_doctor` to see these instructions later.

### Home Manager

Import [this flake](./flake.nix) in your [Home Manager](https://nix-community.github.io/home-manager/) config.

### Dev containers

#### VS Code

In `settings.json`, set `dotfiles.repository` to `forrestjacobs/dotfiles`.

#### Github Codespace

In the [Codespaces settings page](https://github.com/settings/codespaces), check *Automatically install dotfiles* and select *forrestjacobs/dotfiles*.
