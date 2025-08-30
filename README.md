# dotfiles

My dotfiles. Running `install.sh` ① links the [config](./config) directory to `~/.config` and [bin](./bin) to `~/.local/bin` a la GNU Stow, ② installs [some apps](./config/homebrew/Brewfile) if Homebrew is installed, and ③ configures shells and git. It supports fish and bash by sourcing in the output of [`./bin/init_shell`](./bin/init_shell).

## Setup

### Mac or Debian 12+

1. Install [Homebrew](https://brew.sh/).
2. Install and set up [gh](https://cli.github.com/).
   ```bash
   brew install gh
   gh auth login
   gh auth setup-git
   ```
3. Check out this project and run `./install.sh`. There may be additional instructions listed at the end of the script's output.

### Debian 12+ dev containers

#### VS Code

In `settings.json`, set `dotfiles.repository` to `forrestjacobs/dotfiles`.

#### Github Codespace

In the [Codespaces settings page](https://github.com/settings/codespaces), check *Automatically install dotfiles* and select *forrestjacobs/dotfiles*.
