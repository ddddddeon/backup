#!/usr/bin/env bash
# Backup & Encrypt
# C. d'Eon
# 2014

today=`date +_%m_%d_%y`

echo "please enter the directory you want to back up! ABSOLUTE PATH ONLY "
read backup_files

echo "please enter a destination directory! (no slash at the end) ABSOLUTE PATH ONLY "
read dest 

destfree=`df -h $dest | grep / | awk '{ print $4}'`
destfree2=`df $dest | grep / | awk '{ print $4}'`
backupsize=`du -hs $backup_files | head -c 4`
backupsize2=`du $backup_files | awk '{ print $1}'` 

echo "NOTICE: " $backup_files "is" $backupsize "in size, and you have" $destfree" free on the target volume. OK to backup" $backup_files "into" $dest "? (y/n)"
read yn

if [[ $yn == [Yy] ]] && [[ $backupsize2 < $destfree2 ]]; then
    cd $dest
    mkdir BACKUP$today
    cp -R -v $backup_files $dest/BACKUP$today
    tar -cvf BACKUP$today.tar $dest/BACKUP$today
    gpg -v -e BACKUP$today.tar
    rm -rf BACKUP$today
    rm -rf BACKUP$today.tar

else
    echo "canceled!"
    exit 0

fi
