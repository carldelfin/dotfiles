#!/bin/bash

# --------------------------------------------------------------------------------------------------
#
# This script performs backup daily, weekly and monthly backups of $HOME. 
# It is best run as a cronjob. Do not rely solely on this! 
# Remember to follow best practices and keep offsite backups!
#
# --------------------------------------------------------------------------------------------------

rsync -az --delete --quiet $HOME /media/cmd/daily/

# if today is sunday, do weekly backup 
if [[ $(date +%u) == 7 ]]; then
    rsync -az --delete --quiet /media/cmd/daily /media/cmd/weekly/
fi

# if today is last day of month, do monthly backup 
if [[ $(date -d "$1 + 1 day" +%d) == 01 ]]; then
    rsync -az --delete --quiet /media/cmd/daily /media/cmd/monthly/
fi
