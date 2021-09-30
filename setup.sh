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

set_prezto() {
    if [ ! -d "$HOME/.zprezto" ]; then
        git clone --recursive \
            https://github.com/sorin-ionescu/prezto.git \
            $HOME/.zprezto
    else
        echo "$HOME/.zprezto already exists"
    fi

    echo "~/.zprezto/runcomsにある"
    echo "zsh系の設定ファイルを一旦削除"

    cd ~/.zprezto/runcoms
    rm -rf z*

    echo "~/.zprezto/runcomsに"
    echo ".z系のシンボリックリンクを貼る"
    echo "本来なら~/.zprezto/runcoms側から貼るけど"
    echo "dotfiles管理のために逆から貼る"

    ln -s $HOME/.zlogin $HOME/.zprezto/runcoms/zlogin &&
        ln -s $HOME/.zlogout $HOME/.zprezto/runcoms/zlogout &&
        ln -s $HOME/.zpreztorc $HOME/.zprezto/runcoms/zpreztorc &&
        ln -s $HOME/.zprofile $HOME/.zprezto/runcoms/zprofile &&
        ln -s $HOME/.zshenv $HOME/.zprezto/runcoms/zshenv &&
        ln -s $HOME/.zshrc $HOME/.zprezto/runcoms/zshrc

    echo "######################################"
    echo "Success!"
    echo "######################################"
}

# setup Prezto
set_prezto

# install z
if ! command -v z >/dev/null 2>&1; then
    echo 'install z..'
    git clone https://github.com/rupa/z.git $HOME/z
else
    echo 'z already installed.'
fi

echo

cat <<END
**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************
END
