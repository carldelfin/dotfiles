# push changes in dotfiles to github
dotpush() {
	cd ~/dotfiles
        git pull # to avoid conflicts
    	git add .
    	if [ -z "$1" ]; then
    		git commit -m "Automated dotfiles commit + push from terminal"
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
