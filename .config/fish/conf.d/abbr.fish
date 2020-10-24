abbr -a -U -- dta 'dots add -p'
abbr -a -U -- dtc 'dots commit -v'
abbr -a -U -- dtp 'dots push'
abbr -a -U -- dts 'dots status'
abbr -a -U -- gap 'git add -p'
abbr -a -U -- gcb 'git checkout -b'
abbr -a -U -- gcv 'git commit -v'
abbr -a -U -- gfa 'git fetch --all'
abbr -a -U -- gll 'git pull'
abbr -a -U -- gpf 'git push --force-with-lease'
abbr -a -U -- gps 'git push'
abbr -a -U -- grh 'git reset --hard'
abbr -a -U -- gst 'git status'
abbr -a -U -- gsw 'git switch'
abbr -a -U -- mux tmuxinator
abbr -a -U -- nv nvim
abbr -a -U -- tf tmuxinator-fzf-start.sh
abbr -a -U -- v vim

alias tmn="tmux new -s"
alias tml="tmux ls | fzf"
alias tmk="tmux kill-session -t"
alias tma="tmux attach-session -t"

function gco -d "Fuzzy-find and checkout a branch"
	git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function gpsu -d "gpsu git push set upstream branch"
	git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end

function gcoc -d "Fuzzy-find and checkout a commit"
	git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function dots -d "dots alias for dotfiles"
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
