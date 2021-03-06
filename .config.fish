set fish_greeting ''

set --global --export TERM xterm-256color
set -x --global EDITOR vim

alias ls="ls --color=auto"
alias ll="ls -l"
alias vi="vim"
alias tmux="tmux -2"
alias se="sudoedit"

alias open xdg-open

# promptline
function fish_prompt
	env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.promptline.sh left
end

function fish_right_prompt
	env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.promptline.sh right
end
