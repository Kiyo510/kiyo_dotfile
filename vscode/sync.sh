#!/bin/sh
set -exu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
DATE=$(date +%s)

echo "start sync vscode.."
if [ ! -d "$VSCODE_SETTING_DIR" ]; then
     mkdir -p "$VSCODE_SETTING_DIR"
fi

if [ -L "${VSCODE_SETTING_DIR}/settings.json" -o -f "${VSCODE_SETTING_DIR}/settings.json" ]; then
    mv "${VSCODE_SETTING_DIR}/settings.json" "${VSCODE_SETTING_DIR}/settings_$DATE.json"
fi
ln -s "${SCRIPT_DIR}/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

if [ -L "${VSCODE_SETTING_DIR}/keybindings.json" -o -f "${VSCODE_SETTING_DIR}/keybindings.json" ]; then
    mv "${VSCODE_SETTING_DIR}/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings_$DATE.json"
fi
ln -s "${SCRIPT_DIR}/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

if [ -x "$(command -v code)" ]; then
    cat <./extensions | while read -r line; do
        code --install-extension "$line"
    done

    code --list-extensions >extensions
else
    echo "VSCode is not installed."
fi
echo "success!"
