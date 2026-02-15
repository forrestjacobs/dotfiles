# Forrest's dotfiles

This repository contains scripts and config files for my Mac & Linux development environments. Running `install.sh` installs [my config files](./home), adds [my scripts](./home/.local/bin) to `$PATH`, and installs [some packages](./home/.config/homebrew/Brewfile) via [Homebrew](https://brew.sh/). It supports [fish](https://fishshell.com/), [bash](https://www.gnu.org/software/bash/), and [zsh](https://www.zsh.org/) by sourcing in the output of [`dot_shell [fish|bash|zsh]`](./home/.local/bin/dot_shell).

## Used on

- Recent macOS
- Debian 12+ (both as a host and in a dev container)
- Recent NixOS via [Home Manager](https://nix-community.github.io/home-manager/)

## Setup

### Mac or Debian

Check out this project and run `./install.sh`.

There will be additional instructions printed at the end of the script's output. Run `dot_doctor` to see these instructions later.

#### Setting up new Debian host

```bash
# Install dependencies
sudo apt update && sudo apt upgrade
sudo apt install build-essential curl fish git

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
brew install gcc gh

# Set up gh
gh auth login
gh auth setup-git

# Install dotfiles
gh repo clone forrestjacobs/dotfiles
./dotfiles/install.sh
# in a new terminal:
dot_doctor
```

### Home Manager

Import [this flake](./flake.nix) in your [Home Manager](https://nix-community.github.io/home-manager/) config.

### Dev containers

#### VS Code

In `settings.json`, set `dotfiles.repository` to `forrestjacobs/dotfiles`.

#### GitHub Codespace

In the [Codespaces settings page](https://github.com/settings/codespaces), check *Automatically install dotfiles* and select *forrestjacobs/dotfiles*.
