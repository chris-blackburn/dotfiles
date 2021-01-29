#!/bin/bash

test -f "$PWD/install.sh" || (echo "Please run this script within the dotfiles directory"; exit 1)

echo "Initializing Submodules"
git submodule update --init || (echo "Failed to initialize submodules"; exit 1)

if [ ! -d "./dotbak" ]; then
	mkdir dotbak
fi

echo "Backing up original files"
for f in ~/.bash_profile ~/.bashrc ~/.vim ~/.vimrc ~/.ctags ~/.tmux.conf ~/.tmuxline.sh \
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
mkdir -p ~/.config/fish
ln -s "$PWD/.config.fish" ~/.config/fish/config.fish
ln -s "$PWD/.gitignore_global" ~/.gitignore_global

# Create promptline and tmuxline files for nice styling (based on vimrc theme)
vim "+PromptlineSnapshot! ~/.promptline.sh" "+qall"
vim "+Tmuxline lightline" "+TmuxlineSnapshot! ~/.tmuxline.sh" "+qall"

echo "Updating git global config to use global .gitignore"
git config --global core.excludesfile ~/.gitignore_global

echo "Making GDB cool"
wget -qNP ~ https://git.io/.gdbinit

echo "Done"
echo "Make sure to go to https://github.com/powerline/fonts.git to get some good fonts"
