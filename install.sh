#!/bin/bash

set -e

_root=$(realpath $(dirname -- "$0"))

files=(
    "zshrc"
    "zshenv"
    "aliases"
    "gitignore"
    "tmux.conf"
    "vim"
    "ctags"
    "config"
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

echo "Changing shell to zsh"
(which zsh >/dev/null && chsh -s $(which zsh)) || (echo "Couldn't change shell to zsh (is it installed?)")
