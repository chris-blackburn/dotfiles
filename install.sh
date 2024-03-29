#!/bin/bash

set -e

_root=$(realpath $(dirname -- "$0"))

git submodule update --init || (echo "Failed to initialize submodules"; exit 1)

# Some fancy GDB nonsense
wget -qN https://git.io/.gdbinit -O $_root/gdbinit
curl -Lso $_root/lldbinit https://github.com/gdbinit/lldbinit/blob/master/lldbinit.py

files=(
    "zshrc"
    "zshenv"
    "aliases"
    "gitignore"
    "tmux.conf"
    "vim"
    "ctags"
    "fzf"
    "config"
    "gdbinit"
    "lldbinit"
    "dotbin"
)

for file in "${files[@]}"; do
    tgt="${HOME}/.${file}"
    if [[ ! -e $tgt ]]; then
        cmd="ln -s '$_root/$file' '$tgt'"
        echo "$cmd"
        eval "$cmd"
    else
        echo "already exists: '$tgt'"
    fi
done

git config --global core.excludesfile ${HOME}/.gitignore
git config --global core.pager 'less -F -X'
git config --global merge.tool vimdiff
git config --global alias.co checkout
git config --global alias.wt worktree

# Create promptline and tmuxline files for nice styling (based on vimrc theme).
# This has to be done in a tmux session or else the tmuxline command won't
# work.
tmux new-session -d ./$_root/makeprompt.sh

# Download a patched font
if [[ ! -f $_root/font.ttf ]]; then
    curl -Lso $_root/font.ttf https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
fi

# Install fzf (if not already installed)
(which fzf >/dev/null && source $_root/fzf/install --completion --key-bindings --no-bash --no-fish --no-update-rc)

echo "Changing shell to zsh"
(which zsh >/dev/null && chsh -s $(which zsh)) || (echo "Couldn't change shell to zsh (is it installed?)")
