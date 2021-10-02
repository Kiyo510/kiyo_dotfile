# kiyo_dotfiles [![macos](https://github.com/Kiyo510/dotfiles/actions/workflows/macos.yml/badge.svg)](https://github.com/Kiyo510/dotfiles/actions/workflows/macos.yml)

## Install

Run this:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Kiyo510/dotfiles/master/setup.sh)"
source ~/.zshrc && zinit self-update
```

## Usage

Install Brewfile:

```bash
make brew-bundle
```

Sync VSCode Settings:

```bash
make sync-vscode
```

Setting dotfiles symbolic link:

```bash
make deploy
```
