#!/bin/bash

set -xeu

set_symbolic_link() {
    THIS_DIR=$HOME/dotfiles

    for f in .??*; do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".gitconfig.local.template" ]] && continue
        [[ "$f" =~ .zl|.zpr|.zsh|.ssh|.aws|.DS_Store|.gitignore|.gitmodules ]] && continue

        ln -snfv "$THIS_DIR/$f" ~/
    done
    echo "success!"
}

set_symbolic_link
