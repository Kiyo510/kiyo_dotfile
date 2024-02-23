#!/bin/bash
cat <<'EOF'

  __          __       ___      ___
 /\ \        /\ \__  /'___\ __ /\_ \
 \_\ \    ___\ \ ,_\/\ \__//\_\\//\ \      __    ____
 /'_` \  / __`\ \ \/\ \ ,__\/\ \ \ \ \   /'__`\ /',__\
/\ \L\ \/\ \L\ \ \ \_\ \ \_/\ \ \ \_\ \_/\  __//\__, `\
\ \___,_\ \____/\ \__\\ \_\  \ \_\/\____\ \____\/\____/
 \/__,_ /\/___/  \/__/ \/_/   \/_/\/____/\/____/\/___/


EOF

set -eu

PROJECT_ROOT="$HOME/dotfiles"

echo "start setup..."
if [ ! -d "$PROJECT_ROOT" ]; then
    git clone https://github.com/Kiyo510/dotfiles.git "$PROJECT_ROOT"
else
    echo "$PROJECT_ROOT already downloaded. Updating..."
    cd "$PROJECT_ROOT"
    git stash
    git checkout master
    git pull origin master
fi

cd "$PROJECT_ROOT"
source "$PROJECT_ROOT/link.sh"

if ! command -v brew >/dev/null 2>&1; then
    # Install homebrew: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval '$(/opt/homebrew/bin/brew shellenv)'" >> "$HOME/.zprofile"
fi

# 前回のコミットと比較してBrewfileに差分が無ければskipする
if [ "${SKIP_BREW_BUNDLE:-}" != "true" ]; then
    brew bundle --file="$PROJECT_ROOT/Brewfile"
fi

cd "$PROJECT_ROOT"
source "$PROJECT_ROOT/vscode/sync.sh"
source "$PROJECT_ROOT/alfred/sync.sh"
source "$PROJECT_ROOT/alacritty/sync.sh"
source "$PROJECT_ROOT/zsh/macos_defaults.sh"
source "$PROJECT_ROOT/git/sync.sh"
source "$PROJECT_ROOT/asdf/go/sync.sh"

# install z
if ! command -v z >/dev/null 2>&1; then
    echo 'install z..'
    cd "$HOME"
    git clone https://github.com/rupa/z.git "$HOME/z"
else
    echo 'z already installed.'
fi

# source "$PROJECT_ROOT/vim/skk.sh"

# install zinit
# ref: https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#manual
exec zsh

cat <<END
**************************************************
DOTFILES SETUP FINISHED! 
**************************************************
END
