# push changes in dotfiles to github
dotpush() {
	cd ~/dotfiles
    	git add .
    	if [ -z "$1" ]; then
    		git commit -m "Automated dotfiles commit + push via terminal"
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

# open zathura in tabbed mode
ztab() {
    tabbed -c zathura "$1" -e
}

