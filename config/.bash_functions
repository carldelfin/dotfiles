# push changes in dotfiles to github
dotpush() {
	cd ~/dotfiles
    	git add .
    	if [ -z "$1" ]; then
    		git commit -m "Minor changes"
	else
		git commit -m "$*"
	fi
    	git push
	cd
}

# pull changes in dotfiles from github
dotpull() {
	cd ~/dotfiles
	git pull
	cd
}
