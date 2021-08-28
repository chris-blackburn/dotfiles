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
    "dircolors"
)

for file in "${files[@]}"; do
    cmd="ln -sf '$PWD/$file' ~/.'$file'"
    echo "$cmd"
    eval "$cmd"
done

git config --global core.excludesfile ~/.gitignore

# Some fancy GDB nonsense
#wget -qNP ~ https://git.io/.gdbinit

# Create promptline and tmuxline files for nice styling (based on vimrc theme)
source $PWD/makeprompt.sh

# Download a patched font
curl -Lso $PWD/installme.ttf https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf

# Put this at the end because it changes dir
source $PWD/fzf/install --completion --key-bindings --no-bash --no-fish --no-update-rc

echo "Install universal-ctags manually or just grab normal ctags"

echo "Make sure to switch shell to zsh"
