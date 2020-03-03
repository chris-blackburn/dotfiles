set fish_greeting ''

set --global --export TERM xterm-256color
set -x --global EDITOR vim

alias ll="ls -l"
alias vi="vim"
alias tmux="tmux -2"

alias open xdg-open

# promptline
function fish_prompt
	env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.promptline.sh left
end

function fish_right_prompt
	env FISH_VERSION=$FISH_VERSION PROMPTLINE_LAST_EXIT_CODE=$status bash ~/.promptline.sh right
end

# Start X at login
if status is-interactive
	if test -z "$DISPLAY" -a $XDG_VTNR = 1
		exec startx -- -keeptty
	end
end
