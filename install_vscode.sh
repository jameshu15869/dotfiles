#!/bin/bash

# Get the absolute path to the directory where this script is located
# This ensures the script works even if you run it from a different directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/vscode"

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Detected macOS"
    TARGET_DIR="$HOME/Library/Application Support/Code/User"
else
    echo "🐧 Detected Linux"
    TARGET_DIR="$HOME/.config/Code/User"
fi

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

link_file() {
    local filename="$1"
    local source_file="$SOURCE_DIR/$filename"
    local target_file="$TARGET_DIR/$filename"

    # Check if the source file exists in my repo
    if [ ! -f "$source_file" ]; then
        echo "⚠️  Skipping $filename (not found in $SOURCE_DIR)"
        return
    fi

    # Check if a file already exists at the dst
    if [ -e "$target_file" ]; then
        # If it's already a symlink pointing to this dir, skip
        if [ -L "$target_file" ] && [ "$(readlink "$target_file")" == "$source_file" ]; then
            echo "✅ $filename is already correctly linked."
            return
        fi

        echo "📦 Backing up existing $filename to ${filename}.bak"
        mv "$target_file" "${target_file}.bak"
    fi

    # Create the symlink
    echo "🔗 Linking $filename..."
    ln -sf "$source_file" "$target_file"
}

echo "Setting up VS Code configurations..."
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"
echo "-----------------------------------"

link_file "settings.json"
link_file "keybindings.json"

echo "-----------------------------------"
echo "🎉 VS Code setup complete!"
