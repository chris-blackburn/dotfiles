#!/bin/bash

test -f "$PWD/install.sh" || (echo "Please run this script within the dotfiles directory"; exit 1)

git submodule update --init || (echo "Failed to initialize submodules"; exit 1)

files=(
    "zshrc"
    "zshenv"
    "aliases"
    "gitignore"
    "tmux.conf"
    "vim"
    "ctags.d"
    "fzf"
)

for file in $files; do
    ln -sf "$PWD/$file" "~/.$file"
done

git config --global core.excludesfile ~/.gitignore

# Some fancy GDB nonsense
#wget -qNP ~ https://git.io/.gdbinit

# Create promptline and tmuxline files for nice styling (based on vimrc theme)
source $PWD/makeprompt.sh

source $PWD/fzf/install --completion --key-bindings --no-bash --no-fish --no-update-rc
