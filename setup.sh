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

THIS_DIR=$HOME/dotfiles

echo "start setup..."
if [ ! -d "$THIS_DIR" ]; then
    git clone https://github.com/Kiyo510/dotfiles.git "$THIS_DIR"
else
    echo "$THIS_DIR already downloaded. Updating..."
    cd "$THIS_DIR"
    git stash
    git checkout master
    git pull origin master
fi

cd $THIS_DIR
source $THIS_DIR/link.sh

if ! command -v brew >/dev/null 2>&1; then
    # Install homebrew: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
fi

if [ "${SKIP_BREW_BUNDLE:-}" != "true" ]; then
    brew bundle --file=$THIS_DIR/Brewfile
fi

cd $THIS_DIR
source $THIS_DIR/vscode/sync.sh
source $THIS_DIR/alfred/sync.sh
source $THIS_DIR/alacritty/sync.sh
source $THIS_DIR/zsh/macos_defaults.sh

# install z
if ! command -v z >/dev/null 2>&1; then
    echo 'install z..'
    cd $HOME
    git clone https://github.com/rupa/z.git $HOME/z
else
    echo 'z already installed.'
fi

exec zsh
zinit self-update

cat <<END
**************************************************
DOTFILES SETUP FINISHED! 
PLEASE NEXT RUN "source ~/.zshrc && zinit self-update" 
**************************************************
END
