#!/bin/bash

set -xeu

THIS_DIR=$HOME/dotfiles

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
echo "success!"
