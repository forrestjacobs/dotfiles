# dotfiles

My dotfiles. Running `install.sh` ① links the [config](./config) directory to `~/.config` and [bin](./bin) to `~/.local/bin` a la GNU Stow, ② installs [some apps](./config/homebrew/Brewfile) if Homebrew is installed, and ③ configures shells and git. It supports fish and bash by sourcing in the output of [`init_shell [fish|bash]`](./bin/init_shell).

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
