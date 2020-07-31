function pack -a cmd -d "Vim package installer"
cd ~/.vim
switch "$cmd"
case dry-add
		for x in (find . -mindepth 1 -type d)
				if test -d $x/.git
						cd $x
						set git_origin (git config --get remote.origin.url)
						cd - >/dev/null
						echo git submodule add $git_origin $x
				end
		end
case add
		for x in (find . -mindepth 1 -type d)
				if test -d $x/.git
						cd $x
						set git_origin (git config --get remote.origin.url)
						cd - >/dev/null
						git submodule add $git_origin $x
				end
		end
case update
		git submodule foreach git pull
end
end
