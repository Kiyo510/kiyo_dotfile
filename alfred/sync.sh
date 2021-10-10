#!/bin/sh
set -exu

ALFRED_STTING_DIR="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences"
DATE=$(date +%s)

echo "start sync alfred.."
if [ ! -d "$ALFRED_STTING_DIR" ]; then
    mkdir -p "$ALFRED_STTING_DIR"
fi

if [ -L "${ALFRED_STTING_DIR}" -o -d "${ALFRED_STTING_DIR}" ]; then
    mv "${ALFRED_STTING_DIR}" "${ALFRED_STTING_DIR}_$DATE"
fi

source "$HOME"/dotfiles/link.sh
link_directory "$HOME/dotfiles/alfred/Alfred.alfredpreferences" "$ALFRED_STTING_DIR"
