#!/bin/bash

set -exu

THIS_DIR=$HOME/dotfiles
ZSH_DIR=$THIS_DIR/zsh/

echo "deploy starting..."
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".github" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitconfig.local.template" ]] && continue
    [[ "$f" =~ .ssh|.aws|.DS_Store|.gitmodules ]] && continue
    ln -snfv "$THIS_DIR/$f" ~/
done

cd $ZSH_DIR
for f in .??*; do
    [[ "$f" =~ .ssh|.aws|.DS_Store|.gitignore|.gitmodules ]] && continue
    ln -snfv "$ZSH_DIR/$f" ~/
done
echo "success!"
