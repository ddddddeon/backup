Backup & Encrypt: A simple bash script that backs up a user-defined folder into a user-defined folder, compresses the contents, encrypts the .tar with GPG, then deletes the unencrypted copied files, leaving an encrypted backup of your directory.

Usage:

./backup2.sh [folder to backup] [destination folder]
 + Enter your PGP key when prompted.

If no arguments given:

+ Enter your source folder when prompted.
+ Enter your destination folder when prompted.
+ Enter your PGP key when prompted.
