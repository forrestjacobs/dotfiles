# Forrest's dotfiles

This repository contains [chezmoi](https://www.chezmoi.io/)-managed dotfiles for my Mac & Linux development environments. It contains [my config files](./home) and adds [my scripts](./home/dot_local/bin) to `$PATH`. It supports [fish](https://fishshell.com/), [bash](https://www.gnu.org/software/bash/), and [zsh](https://www.zsh.org/) by sourcing in the output of [`dot_shell [fish|bash|zsh]`](./home/dot_local/bin/executable_literal_dot_shell).

## Used on

- Recent macOS
- Debian 12+ (both as a host and in a dev container)

## Setup

### Mac or Debian

Install [chezmoi](https://www.chezmoi.io/) and then init:

```bash
chezmoi init https://github.com/forrestjacobs/dotfiles.git
```

There will be additional instructions printed at the end of the script's output. Run `dot_setup` to see these instructions later.

#### Setting up new Debian host

```bash
# Install dependencies
sudo apt update && sudo apt upgrade
sudo apt install build-essential chezmoi curl fish git

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
brew install gcc gh

# Set up gh
gh auth login
gh auth setup-git

# Install dotfiles
chezmoi init https://github.com/forrestjacobs/dotfiles.git
```

### Dev containers

#### VS Code

In `settings.json`, set `dotfiles.repository` to `forrestjacobs/dotfiles`.

#### GitHub Codespace

In the [Codespaces settings page](https://github.com/settings/codespaces), check *Automatically install dotfiles* and select *forrestjacobs/dotfiles*.
