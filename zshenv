export TERM="screen-256color"
export EDITOR=vim
export VISUAL=$EDITOR
export LESS="$LESS -R -Q"

export PATH=~/.dotbin:$PATH

# This is supposed to make the right prompt flush against
# the terminal, but it breaks the prompt.
export ZLE_RPROMPT_INDENT=0
