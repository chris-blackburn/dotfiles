# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
bind -r '\C-s'
stty -ixon

export TERM=xterm-256color
export EDITOR=vim

alias ll="ls -l"
alias vi="vim"
alias vimr="vim -R"
alias tmux="tmux -2"

source ~/.promptline.sh
