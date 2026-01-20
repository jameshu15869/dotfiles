printf "\nCreating symlinks\n"

if ! command -v stow &>/dev/null; then
    echo "Error: GNU Stow is not installed."
    exit 1
fi

command stow $STOW_FLAGS . -t ~
