function tm -a cmd -d "Tmux shortcuts"
    switch "$cmd"
    	case n
		# Create a new tmux session
		tmux new -s $argv
	case l
		# List tmux sessions
		tmux ls | fzf
	case k
		# kill tmux session
		tmux kill-session -t $argv
	case a
		tmux attach-session -t $argv
        case \*
		# Unknown command
		echo "Tmux: unknown flag or command \"$cmd\" ⁉️"
		_tmux_help
    end
end

function _tmux_help
    echo "usage: tm n <session name...>  Create new session"
    echo "       tm l        		 list all sessions"
    echo "       tm k <session name...>  kill session"
    echo "       tm a <session name...>  Attach to session"
    echo "examples:"
    echo "       tm n work-session"
    echo "       tm a work-session"
end
