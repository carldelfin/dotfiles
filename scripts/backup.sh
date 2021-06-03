# -----------------------------------------------------------------------------------
# daily mirror and backup
# -----------------------------------------------------------------------------------

# do we have a log file?
mkdir -p ~/logs

if [ ! -f ~/logs/backup.log  ]
then
    touch ~/logs/backup.log
fi

dirs_to_sync=(~/.gnupg ~/.ssh ~/.password-store ~/dotfiles ~/Documents ~/Downloads ~/Zotero ~/qmk_firmware/keyboards)

for i in "${dirs_to_sync[@]}"; do
	
	rsync -az --delete --quiet $i /media/cmd/mirror/
	now=$(date "+%Y-%m-%d %H:%M:%S")
	echo "$now Syncing $i to /media/cmd/mirror complete" >> ~/logs/backup.log

	rsync -az --delete --quiet $i /media/cmd/archive/mirror
	now=$(date "+%Y-%m-%d %H:%M:%S")
	echo "$now Syncing $i to /media/cmd/archive/mirror complete" >> ~/logs/backup.log
done

# check disk usage on /media/cmd/archive
# TODO: refactor this to someting simpler
percent_used=$(df -hl /media/cmd/archive | awk '{print $5}' | tail -n1 | sed 's/%//')

# if 95% or more of available disk space is used, delete the oldest tarball
if [[ $percent_used -ge 95 ]]
then               
    cd /media/cmd/archive/tarballs
    rm "$(ls -t | tail -1)"
    cd
	now=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$now Limited disk space on /media/cmd/archive ($percent_used% is used), had to delete oldest tarball" >> ~/logs/backup.log
else
	now=$(date "+%Y-%m-%d %H:%M:%S")
	echo "$now Note! $percent_used% of disk space on /media/cmd/archive is used" >> ~/logs/backup.log
fi

    
# create tarball 
today=$(date +"%Y%m%d")
tar -cJf /media/cmd/archive/tarballs/mirror_${today}.tar.xz /media/cmd/archive/mirror
now=$(date "+%Y-%m-%d %H:%M:%S")
echo "$now Tarball of /media/cmd/archive/mirror complete" >> ~/logs/backup.log
