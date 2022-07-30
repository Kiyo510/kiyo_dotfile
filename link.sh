#!/bin/bash

set -exu

THIS_DIR=$HOME/dotfiles
ZSH_DIR=$THIS_DIR/zsh/

echo "deploy starting..."

link_directory() {
    local from="$1"
    local to="$2"

    if [[ -d $from ]]; then
        if [[ -L "$to" ]]; then
            echo "Directory "$to" already exists as a link, skipping link"
        elif [[ -d "$to" ]]; then
            echo 1>&2 "Directory "$to" exists but is not a link"
            echo 1>&2 "Aborting due to unexpected state!"
            exit 1
        else
            echo "Linking directory $from to $to"
            ln -sf "$from" "$to"
        fi
    fi
}

for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".github" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitconfig.local.template" ]] && continue
    [[ "$f" =~ .ssh|.aws|.DS_Store|.gitmodules|.idea ]] && continue
    ln -snfv "$THIS_DIR/$f" ~/
done

cd $ZSH_DIR
for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".github" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".gitconfig.local.template" ]] && continue
    [[ "$f" =~ .ssh|.aws|.DS_Store|.gitignore|.gitmodules|.idea ]] && continue
    ln -snfv "$ZSH_DIR/$f" ~/
done

echo "success!"
