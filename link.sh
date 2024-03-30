#!/bin/bash

set -exu

PROJECT_ROOT=$HOME/dotfiles
ZSH_DIR=$PROJECT_ROOT/zsh
VIM_DIR=$PROJECT_ROOT/vim
PHPSTORM_DIR=$PROJECT_ROOT/phpstorm
TMUX_DIR=$PROJECT_ROOT/tmux

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

link_dotfiles() {
    cd "$1"

    for f in .??*; do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".github" ]] && continue
        [[ "$f" == ".gitignore" ]] && continue
        [[ "$f" == ".gitconfig.local.template" ]] && continue
        [[ "$f" =~ .ssh|.aws|.DS_Store|.gitmodules|^\.idea$|^\.vscode$ ]] && continue
        ln -snfv "$1/$f" ~/
    done
}

link_dotfiles "$PROJECT_ROOT"
link_dotfiles "$ZSH_DIR"
link_dotfiles "$VIM_DIR"
link_dotfiles "$PHPSTORM_DIR"
link_dotfiles "$TMUX_DIR"

echo "success!"
