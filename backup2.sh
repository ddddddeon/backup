#!/usr/bin/env bash

# Backup & Encrypt
# C. d'Eon
# 2014

today=`date +_%m_%d_%y`

if [[ -d $1 ]] && [[ -d $2 ]]; then
    backup_files=$1
    dest=$2
    clear

else
    clear
    echo "*** Usage: ./backup.sh [folder to backup] [destination folder]"
    echo "(ABSOLUTELY PATHS ONLY, NO '~')"
    echo ""
    echo "please enter the directory you want to back up! ABSOLUTE PATH ONLY "
    read -p "> " backup_files

    if [[ ! -e $backup_files ]]; then 
	echo "directory does not exist!"
	exit 0
    fi

    echo "please enter a destination directory! ABSOLUTE PATH ONLY "
    read -p "> " dest 
    if [[ ! -e $dest ]]; then
	echo "directory does not exist!"
	exit 0
    fi

fi 

echo "one moment..."

destfree=`df -h $dest | grep / | awk '{ print $4}'`
destfree2=`df $dest | grep / | awk '{ print $4}'`
backupsize=`du -hs $backup_files | awk '{ print $1}'`
backupsize2=`du $backup_files | awk '{ print $1}'` 

echo ""
echo "*** Notice: $backup_files is $backupsize in size, and you have $destfree free on the target volume. OK to backup $backup_files into $dest? (y/n)"
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
