#!/bin/bash

_root=$(realpath $(dirname "$0"))

git submodule update --init || (echo "Failed to initialize submodules"; exit 1)

files=(
    "zshrc"
    "zshenv"
    "aliases"
    "gitignore"
    "tmux.conf"
    "vim"
    "ctags"
    "fzf"
)

for file in "${files[@]}"; do
    cmd="ln -sf '$_root/$file' ~/.'$file'"
    echo "$cmd"
    eval "$cmd"
done

git config --global core.excludesfile ~/.gitignore
git config --global merge.tool vimdiff
git config --global alias.co checkout

# Some fancy GDB nonsense
wget -qNP ~ https://git.io/.gdbinit

# Create promptline and tmuxline files for nice styling (based on vimrc theme)
source $_root/makeprompt.sh

# Download a patched font
curl -Lso $_root/font.ttf https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf

# Install fzf
source $_root/fzf/install --completion --key-bindings --no-bash --no-fish --no-update-rc

echo "Changing shell to zsh"
(which zsh >/dev/null && chsh -s $(which zsh)) || (echo "Couldn't change shell to zsh (is it installed?)")
