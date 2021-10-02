#!/bin/bash

set -xeu

cat <<'EOF'

  __          __       ___      ___
 /\ \        /\ \__  /'___\ __ /\_ \
 \_\ \    ___\ \ ,_\/\ \__//\_\\//\ \      __    ____
 /'_` \  / __`\ \ \/\ \ ,__\/\ \ \ \ \   /'__`\ /',__\
/\ \L\ \/\ \L\ \ \ \_\ \ \_/\ \ \ \_\ \_/\  __//\__, `\
\ \___,_\ \____/\ \__\\ \_\  \ \_\/\____\ \____\/\____/
 \/__,_ /\/___/  \/__/ \/_/   \/_/\/____/\/____/\/___/


EOF

THIS_DIR=$HOME/dotfiles

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

echo "start setup..."
source $(cd $(dirname $0) && pwd)/link.sh

if ! command -v brew >/dev/null 2>&1; then
    # Install homebrew: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle

cd $THIS_DIR
source $(cd $(dirname $0) && pwd)/vscode/sync.sh

# install z
if ! command -v z >/dev/null 2>&1; then
    echo 'install z..'
    git clone https://github.com/rupa/z.git $HOME/z
else
    echo 'z already installed.'
fi

cat <<END
**************************************************
DOTFILES SETUP FINISHED! bye.
PLEASE NEXT RUN "source ~/.zshrc"
**************************************************
END
