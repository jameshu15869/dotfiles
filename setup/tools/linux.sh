#!/usr/bin/env bash

printf "\nInstalling tools\n"

echo "- update apt-get"
sudo apt-get $APT_FLAGS update >"$OUTPUT"

echo "- cargo"
# cargo is needed for some tools, so we install it first
(curl https://sh.rustup.rs -sSf | sh $SH_FLAGS -- -y -q) >"$OUTPUT" 2>"$OUTPUT"
. "$HOME/.cargo/env"

echo "- neovim (through bob)"
# sudo apt-get $APT_FLAGS install neovim &>"$OUTPUT"
(curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash $SH_FLAGS) &>"$OUTPUT"
bob install latest

echo "- fzf"
git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &>"$OUTPUT"
~/.fzf/install --all &>/dev/null

echo "- zoxide"
(curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh $SH_FLAGS) &>"$OUTPUT"

echo "- starship"
(curl -sSfL https://starship.rs/install.sh | sh $SH_FLAGS -- -y) &>"$OUTPUT"
