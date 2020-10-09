function gt -a cmd -d "Git utilities"
	switch "$cmd"
		case up
			git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
		case ch
			git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
		case co
			git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
		case \*
			# Unknown command
			echo "gt: unknown flag or command \"$cmd\" ⁉️"
			_git_help
	end
end

function _git_help
	echo "usage: gt up  Git push upstream"
	echo "       gt ch   Fuzzy search and checkout branch"
	echo "       gt co 	Fuzzy search and checkout commit"
	echo "examples:"
	echo "       gt ch"
end
