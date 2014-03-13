#!/usr/bin/env bash                                        

today=`date +_%m_%d_%y`

echo "please enter the directory you want to back up! ABSOLUTE PATH ONLY "
read backup_files

echo "please enter a destination directory! (no slash at the end) ABSOLUTE PATH ONLY "
read dest 

echo "would you like to backup " $backup_files " into " $dest "? (y/n): "
read yn

if [[ $yn == [Yy] ]]; then
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
