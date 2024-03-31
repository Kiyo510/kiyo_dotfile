#!/bin/sh
set -exu

GIT_CONFIG_DIR="$HOME/.config/git"
DATE=$(date +%s)

echo "start sync git config.."
if [ -L "${GIT_CONFIG_DIR}" -o -d "${GIT_CONFIG_DIR}" ]; then
    mv "${GIT_CONFIG_DIR}" "${GIT_CONFIG_DIR}_$DATE"
fi

if [ ! -d "$GIT_CONFIG_DIR" ]; then
    mkdir -p "$GIT_CONFIG_DIR"
fi

 ln -snfv "$HOME/dotfiles/git/ignore" "${GIT_CONFIG_DIR}/ignore"
