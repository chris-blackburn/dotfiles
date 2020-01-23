#!/bin/bash

echo "Initializing Submodules"
git submodule update --init --progress

echo "Backing up original files"
for f in ~/.bash_profile ~/.bashrc ~/.vim ~/.tmux.conf ~/.tmuxline.sh \
	~/.promptline.sh ~/.config/fish/config.fish; do
	mv "$f" "$f".dotbak
done

echo "Linking files to appropriate locations"
ln -s "$PWD/.bash_profile" ~/.bash_profile
ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.vim" ~/.vim
ln -s "$PWD/.tmux.conf" ~/.tmux.conf
ln -s "$PWD/.tmux" ~/.tmux
ln -s "$PWD/.tmuxline.sh" ~/.tmuxline.sh
ln -s "$PWD/.promptline.sh" ~/.promptline.sh
mkdir -p ~/.config/fish
ln -s "$PWD/.config.fish" ~/.config/fish/config.fish

echo "Making GDB cool"
if test -f ~/.gdbinit; then
	echo "GDB already cool"
else
	wget -P ~ https://git.io/.gdbinit
fi

echo "Done"
echo "Note: scrot not automatically installed, do that yourself"
echo "Make sure to go to https://github.com/powerline/fonts.git to get some good fonts"
