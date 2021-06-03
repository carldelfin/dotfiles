# push changes in dotfiles to github
dotpush() {
	cd ~/dotfiles
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

# push changes in website to github
webpush() {
	cd ~/Documents/private/carldelfin.github.io
    	git add .
    	if [ -z "$1" ]; then
    		git commit -m "Automated website commit + push via terminal"
	else
		git commit -m "$*"
	fi
    	git push
	cd
}

# pull changes in website from github
webpull() {
	cd ~/Documents/private/carldelfin.github.ipull
	cd
}

# open zathura in tabbed mode
ztab() {
    tabbed -c zathura "$1" -e
}

