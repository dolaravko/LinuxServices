#!/bin/bash
# 2016.05.10
# create by $avko
#
# 	sentoraFullBackUP.sh

# full day YYYY-MM-DD
#DAY=`date +%Y-%m-%d`
# day in week 
DAY=`date '+%u'`


# backup location on sentora server
FOLDERBACKUP="/home/backup"

# mysql root password
ROOTPASSWORDFORMYSQL="yourMySqlRootPassword"

# ip or host for backup server
BACKUPSERVERIP="backup.server.com"
# user for backup server
BACKUPSERVERUSER="sentora"

# location for backp on backup server
BACKUPSERVERFOLDER="/home/sentora/backup/"

# loacation of ssh private key on sentora server 
BACKUPSERVERPATHTOSSHKEY="/home/backup/script/.ssh/sentora-disk"

# ssh port on backup server
BACKUPSERVERSSHPORT="22"
    



rm -r $FOLDERBACKUP/mysql/*


echo "###################################" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "###################################" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "****** Start full backup  $(date)" >> $FOLDERBACKUP/sentoraFullBackup.log

# Start backup
xtrabackup --backup --datadir=/var/lib/mysql/ --target-dir=$FOLDERBACKUP/mysql/ --user=root --password=$ROOTPASSWORDFORMYSQL >> $FOLDERBACKUP/sentoraFullBackup.log

echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "****** End full backup $(date)" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log


# start tar
echo "****** Start tar backup  $(date)" >> $FOLDERBACKUP/sentoraFullBackup.log

cd $FOLDERBACKUP/
tar -zcf sentoraFullBackup_$DAY.tar.gz mysql/ /etc/sentora/ /var/sentora/ /root/passwords.txt


echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "****** End tar backup  $(date)" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log

# start copy
echo "****** Start copy backup  $(date)" >> $FOLDERBACKUP/sentoraFullBackup.log

scp -P $BACKUPSERVERSSHPORT -i $BACKUPSERVERPATHTOSSHKEY  $FOLDERBACKUP/sentoraFullBackup_$DAY.tar.gz $BACKUPSERVERUSER@$BACKUPSERVERIP:$BACKUPSERVERFOLDER/

rm $FOLDERBACKUP/sentoraFullBackup_$DAY.tar.gz

echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "****** End copy backup  $(date)" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
echo "" >> $FOLDERBACKUP/sentoraFullBackup.log
