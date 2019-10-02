#!/bin/bash
set -e

echo "Initializing Submodules"
git submodule init && git submodule update

echo "Linking files to appropriate locations"
ln -s $PWD/.bash_profile ~/.bash_profile
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.tmuxline.sh ~/.tmuxline.sh
ln -s $PWD/.promptline.sh ~/.promptline.sh
mkdir -p ~/.config/fish
ln -s $PWD/.config.fish ~/.config/fish/config.fish

echo "Done"
