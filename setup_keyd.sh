#!/bin/bash

# Get the absolute path of the directory containing this script
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOURCE_FILE="$REPO_ROOT/keyd/default.conf"
TARGET_LINK="/etc/keyd/default.conf"

echo "Setting up keyd config..."

# Exit if the in-repo file doesn't exist
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Could not find $SOURCE_FILE"
    exit 1
fi

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "Error: keyd should only be used on linux"
    exit 1
fi

#    sudo here because /etc is owned by root
#    -s = symbolic link
#    -f = force (overwrites any existing file or link at the target)
echo "Linking $SOURCE_FILE -> $TARGET_LINK"
sudo ln -sf "$SOURCE_FILE" "$TARGET_LINK"

echo "Reloading keyd..."
sudo keyd reload

echo "Success! keyd is configured."
