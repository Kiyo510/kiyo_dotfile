#!/bin/sh
set -exu

ALACRITTY_SETTING_DIR="$HOME/.config/alacritty"
DATE=$(date +%s)

echo "start sync alacritty.."
if [ -L "${ALACRITTY_SETTING_DIR}" -o -d "${ALACRITTY_SETTING_DIR}" ]; then
    mv "${ALACRITTY_SETTING_DIR}" "${ALACRITTY_SETTING_DIR}_$DATE"
fi

if [ ! -d "$ALACRITTY_SETTING_DIR" ]; then
    mkdir -p "$ALACRITTY_SETTING_DIR"
fi

ln -snfv "$HOME/dotfiles/alacritty/config/alacritty.toml" "${ALACRITTY_SETTING_DIR}/alacritty.toml"
