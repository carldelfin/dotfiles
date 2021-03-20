# -----------------------------------------------------------------------------------
# daily backup
# -----------------------------------------------------------------------------------

# to internal drives
rsync -az --delete --quiet /home /media/cmd/internal1
rsync -az --delete --quiet /home /media/cmd/internal2

# over LAN
rsync -az --delete --quiet -e ssh /home cmd@192.168.20.74:/media/backup_1/daily_mirror

# -----------------------------------------------------------------------------------
# weekly backup
# -----------------------------------------------------------------------------------

# is today friday?
dayofweek=$(date +"%u")
if [ "${dayofweek}" -eq 5 ]; then

    # delete backups older than three months (90 days) to save space
    find /media/cmd/internal1 -maxdepth 1 -type f -name "*.tar.xz" -mtime +90 -exec rm -rf {} \;
    find /media/cmd/internal2 -maxdepth 2 -type f -name "*.tar.xz" -mtime +90 -exec rm -rf {} \;
    
    # set date
    today=$(date +"%Y%m%d")
    
    # create tarballs 
    tar -cJf /media/cmd/internal1/backup_${today}.tar.xz /media/cmd/internal1/home
    tar -cJf /media/cmd/internal2/backup_${today}.tar.xz /media/cmd/internal2/home
    rsync -az --delete --quiet -e ssh /media/cmd/internal2/backup_${today}.tar.xz cmd@192.168.20.74:/media/backup_1/weekly_backup
fi
