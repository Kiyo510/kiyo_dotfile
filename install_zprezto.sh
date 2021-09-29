#!/bin/bash
set_prezto() {

    set -xeu

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
