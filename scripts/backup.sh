#!/bin/bash



# -----------------------------------------------------------------------------------
# daily backup
# -----------------------------------------------------------------------------------

rsync -az --delete --quiet /home /media/cmd/backup
rsync -az --delete --quiet /home /media/cmd/backup_1
rsync -az --delete --quiet -e ssh /home cmd@192.168.20.57:/media/backup_3

# -----------------------------------------------------------------------------------
# weekly backup
# -----------------------------------------------------------------------------------

# is today friday?
# dayofweek=$(date +"%u")
# if [ "${dayofweek}" -eq 5 ];
# then
#     # if friday, do regular mirroring plus weekly backup
#     rsync -az --delete --quiet /home /media/cmd/backup/mirror
#     rsync -az --delete --quiet /home /media/cmd/backup_2/mirror
#     rsync -az --delete --quiet -e ssh /home cmd@192.168.20.57:/media/backup_3/mirror
# 
#     # delete backups older than one month (30 days) to save space
#     find /media/cmd/archive -maxdepth 1 -type f -name "*.tar.xz" -mtime +30 -exec rm -rf {} \;
#     
#     # use multicore tar
#     export XZ_DEFAULTS="-T 12 "
#     
#     today=$(date +"%Y%m%d")
#     tar -cJf /media/cmd/backup_${today}.tar.xz /media/cmd/mirror/
#     tar -cJf /media/cmd/archive/backup_${today}.tar.xz cmd@192.168.20.57:/media/backup_3/backup/
# else
#     rsync -az --delete --quiet /home /media/cmd/backup/mirror
#     rsync -az --delete --quiet /home /media/cmd/backup_2/mirror
#     rsync -az --delete --quiet -e ssh /home cmd@192.168.20.57:/media/backup_3/mirror
# fi
