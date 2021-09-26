#!/bin/bash

# 未定義な変数があったら途中で終了するｓ
set -u

BASEDIR=$(dirname $0)
cd $BASEDIR

for f in .??*; do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".gitignore" ] && continue

    ln -snfv ${PWD}/"$f" ~/
done
