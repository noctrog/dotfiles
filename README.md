# My personal dotfiles

These are the configs for my programs: neovim, helix, zellij, starship, uv, hunkdiff, Ghostty, cmux, ...

The shared UI theme is managed by `environment.sh`. The default is Catppuccin Mocha.

## Installation

Just run:

```bash
git clone https://github.com/noctrog/dotfiles .dotfiles
cd .dotfiles && ./environment.sh
```

The installation sets up Rust, installs the CLI tools, downloads the latest Neovim, Helix, and hunkdiff binaries for the current platform, and links the dotfiles with Tuckr. On macOS, it also installs Ghostty and cmux with Homebrew. It might take a few minutes.

You can also run the install mode explicitly:

```bash
./environment.sh install
```

## Updating

To update the installed tools later, run:

```bash
cd .dotfiles && ./environment.sh update
```

The update mode refreshes Rust, cargo-installed tools, Starship, Neovim stable, the latest Helix release, and the latest hunkdiff release. On macOS, it also upgrades the Ghostty and cmux Homebrew casks.

Individual binary tools can be updated separately:

```bash
./environment.sh update-neovim
./environment.sh update-helix
./environment.sh update-hunkdiff
./environment.sh update-ghostty
./environment.sh update-cmux
```

Ghostty and cmux are macOS-only in this script. cmux uses the `manaflow-ai/cmux` Homebrew tap before installing the `cmux` cask. The cmux CLI is linked into `~/.local/bin/cmux` when the app provides it.

## Themes

Set a shared theme across Ghostty, cmux, Helix, Neovim, Zellij, Starship, and Zathura:

```bash
./environment.sh theme catppuccin-mocha
```

Supported themes:

```bash
./environment.sh theme-list
```

The current theme is recorded in `.theme`, so future `install` and `update` runs keep using the selected theme. cmux shares the Ghostty config.

## Other commands

Preview an install or update without changing files:

```bash
./environment.sh update --dry-run
```

Remove old extracted Helix and hunkdiff versions while keeping the recorded current versions:

```bash
./environment.sh cleanup
```

Show all available commands:

```bash
./environment.sh --help
```

The script records installed binary versions under `~/.local/share/.dotfiles-tool-versions` so repeated updates can skip tools that are already current.
