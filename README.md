# Forrest's dotfiles

This repository contains scripts and config files for my Linux & Mac development environments. Running `install.sh` installs [my config files](./config), adds [my scripts](./bin) to `$PATH`, and installs [some packages](./config/homebrew/Brewfile) via [Homebrew](https://brew.sh/). It supports [fish](https://fishshell.com/) and [bash](https://www.gnu.org/software/bash/) by sourcing in the output of [`init_shell [fish|bash]`](./bin/init_shell).

## Setup

### Mac or Debian 12+

1. Install [Homebrew](https://brew.sh/). (Optional but recommended.)
2. Install and set up the [GitHub CLI](https://cli.github.com/). (Also optional but recommended.)
   ```bash
   brew install gh
   gh auth login
   gh auth setup-git
   ```
3. Check out this project and run `./install.sh`.

There may be additional instructions printed at the end of the script's output. `install.sh` is idempotent, so you can run it again to see the instructions later.

### NixOS

Only supported by my [private NixOS config](https://github.com/forrestjacobs/nixos-config) -- sorry!

### Debian 12+ dev containers

#### VS Code

In `settings.json`, set `dotfiles.repository` to `forrestjacobs/dotfiles`.

#### Github Codespace

In the [Codespaces settings page](https://github.com/settings/codespaces), check *Automatically install dotfiles* and select *forrestjacobs/dotfiles*.
