export TERM="xterm-256color"
export EDITOR=vim
export VISUAL=$EDITOR
export LESS="$LESS -R -Q -I"

export PATH=~/.local/bin:$PATH

# This is supposed to make the right prompt flush against
# the terminal, but it breaks the prompt.
export ZLE_RPROMPT_INDENT=0
