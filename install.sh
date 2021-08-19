#!/bin/bash

test -f "$PWD/install.sh" || (echo "Please run this script within the dotfiles directory"; exit 1)

git submodule update --init || (echo "Failed to initialize submodules"; exit 1)

ln -sf "$PWD/zshrc" ~/.zshrc
ln -sf "$PWD/zshenv" ~/.zshenv
ln -sf "$PWD/aliases" ~/.aliases
ln -sf "$PWD/vim" ~/.vim
ln -sf "$PWD/ctags" ~/.ctags
ln -sf "$PWD/tmux.conf" ~/.tmux.conf
ln -sf "$PWD/gitignore" ~/.gitignore

# Create promptline and tmuxline files for nice styling (based on vimrc theme)
source "$PWD/makeprompt.sh"

git config --global core.excludesfile ~/.gitignore

# Some fancy GDB nonsense
#wget -qNP ~ https://git.io/.gdbinit
