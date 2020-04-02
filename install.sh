#!/bin/bash

test -f "$PWD/install.sh" || (echo "Please run this script within the dotfiles directory"; exit 1)

echo "Initializing Submodules"
git submodule update --init || (echo "Failed to initialize submodules"; exit 1)

if [ ! -d "./dotbak" ]; then
	mkdir dotbak
fi

echo "Backing up original files"
for f in ~/.bash_profile ~/.bashrc ~/.vim ~/.ctags ~/.tmux.conf ~/.tmuxline.sh \
	~/.promptline.sh ~/.config/fish/config.fish ~/.gitignore_global; do
	mv "$f" "./dotbak/"$(basename -- "$f")
done

echo "Linking files to appropriate locations"
ln -s "$PWD/.bash_profile" ~/.bash_profile
ln -s "$PWD/.bashrc" ~/.bashrc
ln -s "$PWD/.vim" ~/.vim
ln -s "$PWD/.ctags" ~/.ctags
ln -s "$PWD/.tmux.conf" ~/.tmux.conf
ln -s "$PWD/.tmux" ~/.tmux
ln -s "$PWD/.tmuxline.sh" ~/.tmuxline.sh
ln -s "$PWD/.promptline.sh" ~/.promptline.sh
mkdir -p ~/.config/fish
ln -s "$PWD/.config.fish" ~/.config/fish/config.fish
ln -s "$PWD/.gitignore_global" ~/.gitignore_global

echo "Updating git global config to use global .gitignore"
git config --global core.excludesfile ~/.gitignore_global

echo "Making GDB cool"
if test -f ~/.gdbinit; then
	echo "GDB already cool"
else
	wget -P ~ https://git.io/.gdbinit
fi

echo "Done"
echo "Make sure to go to https://github.com/powerline/fonts.git to get some good fonts"
