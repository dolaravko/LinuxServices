#!/bin/bash
# 2016.05.10
# create by $avko
#
# 	deleteOlderBackUp.sh

# day in week 
DAY=`date '+%u'`

# location for backp on backup server
BACKUPSERVERFOLDER="/home/sentora/backup/"


echo "###################################" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "###################################" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "****** Start delete older backup $(date)" >> $FOLDERBACKUP/deleteOlderBackUp.log

rm -r $BACKUPSERVERFOLDER/sentoraFullBackup_$DAY.tar.gz

echo "" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "****** End delete older backup $(date)" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "" >> $FOLDERBACKUP/deleteOlderBackUp.log
echo "" >> $FOLDERBACKUP/deleteOlderBackUp.log
