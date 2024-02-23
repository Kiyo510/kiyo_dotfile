#!/bin/bash
set -eu

SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

GO_TOOL_PATH="$SCRIPT_DIR/go_tool.txt"

if [ ! -f "$GO_TOOL_PATH" ]; then
  echo "go_tool.txt not found."
  exit 1
fi

while IFS= read -r line; do
  echo "installing $line..."
  asdf exec go install "$line@latest"
done < "$GO_TOOL_PATH"

echo "go install done."
