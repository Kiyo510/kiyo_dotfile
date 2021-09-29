#!/bin/bash

set -xeu

THIS_DIR=$HOME/dotfiles

if [ ! -d "$THIS_DIR" ]; then
    git clone https://github.com/Kiyo510/dotfiles.git "$THIS_DIR"
else
    echo "$THIS_DIR already downloaded. Updating..."
    cd "$THIS_DIR"
    git stash
    git checkout master
    git pull origin master
    echo
fi

cd $THIS_DIR

echo "start setup..."

$(./install_zprezto.sh)

for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" = ".gitconfig.local.template" ]] && continue
    [[ "$f" = ".gitmodules" ]] && continue
    [[ "$f" = ".gitignore" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".aws" ]] && continue
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".ssh" ]] && continue

    ln -snfv "$THIS_DIR/$f" ~/
done

if ! command -v brew >/dev/null 2>&1; then
    # Install homebrew: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo
fi

brew bundle

# install z
if ! command -v z >/dev/null 2>&1; then
    echo 'install z..'
    git clone git@github.com:rupa/z.git $HOME/z
else
    echo 'z already installed.'
fi

echo

cat <<END
**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************
END
