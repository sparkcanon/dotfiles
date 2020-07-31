function gpsu -d "gpsu git push set upstream branch"
	git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end
