#!/usr/bin/env bash

printf "\nConfiguring shell\n"

if [[ $OSTYPE != 'darwin'* ]]; then
    echo "- zsh"
    sudo apt -qq install zsh &>/dev/null
    sudo chsh -s $(which zsh) "$USER" >/dev/null
fi

echo "- oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null

echo "- zsh-asdf"
git clone -q https://github.com/asdf-vm/asdf.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/asdf &>/dev/null

echo "- zsh-autosuggestions"
git clone -q https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &>/dev/null

echo "- fast-syntax-highlighting"
git clone -q https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting &>/dev/null

echo "- JetBrains Mono"
[[ $OSTYPE == 'darwin'* ]] &&
    font_path=$HOME/Library/Fonts ||
    font_path=$HOME/.local/share/fonts

mkdir -p "$font_path"

curl -sSOl 'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip'
mkdir JetBrainsMono
unzip -qq JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
cp JetBrainsMono*.ttf "$font_path"
rm -rf JetBrainsMono

if [[ $OSTYPE != 'darwin'* ]]; then
    # reload font cache
    fc-cache -f
fi
