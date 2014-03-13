#!/bin/bash -x

# Backup & Encrypt
# C. d'Eon
# 2014

today=`date +_%m_%d_%y`

echo "please enter the directory you want to back up! ABSOLUTE PATH ONLY "
read -p "> " backup_files

echo "please enter a destination directory! ABSOLUTE PATH ONLY "
read -p "> " dest 
echo "one moment..."

destfree=`df -h $dest | grep / | awk '{ print $4}'`
destfree2=`df $dest | grep / | awk '{ print $4}'`
backupsize=`du -hs $backup_files | awk '{ print $1}'`
backupsize2=`du $backup_files | awk '{ print $1}'` 

echo ""
echo "NOTICE: " $backup_files "is" $backupsize "in size, and you have" $destfree "free on the target volume. OK to backup" $backup_files "into" $dest "? (y/n)"
read -p "> " yn

if [[ $yn == [Yy] ]] && [[ $backupsize2 < $destfree2 ]]; then
    cd $dest
    tar -cvf BACKUP$today.tar $backup_files
    gpg -v -e BACKUP$today.tar
    rm  BACKUP$today.tar

else
    echo "canceled!"
    exit 0

fi
