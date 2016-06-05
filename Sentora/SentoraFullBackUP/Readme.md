# Sentora Full BackUP


## Preparing Sentora server

**1.**Install xtrabackup [percona xtrabackup](https://www.percona.com/doc/percona-xtrabackup/2.4/installation/apt_repo.html)<br>
On Sentora server (Ubuntu):

```
wget https://repo.percona.com/apt/percona-release_0.1-3.$(lsb_release -sc)_all.deb

sudo dpkg -i percona-release_0.1-3.$(lsb_release -sc)_all.deb

sudo apt-get update

sudo apt-get install percona-xtrabackup-24
```

**2.**Create folder for backup on Sentora server<br>

````
mkdir  -p /home/backup
````

**3.**Create folder for mysql backup and script folder on Sentora server<br>

```
mkdir  -p /home/backup/mysql
mkdir  -p /home/backup/script
```

**4.**Download script to folder<br>

```
cd /home/backup/script/
wget https://raw.githubusercontent.com/dolaravko/LinuxServices/master/Sentora/SentoraFullBackUP/sentoraFullBackup.sh
chmod +x /home/backup/script/sentoraFullBackup.sh
```

**5.**Edit sentoraFullBackup.sh with yout parameters ```vim /home/backup/script/sentoraFullBackup.sh```

```
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
```

**6.**Create cron job ( cron job will run in 3 hours)

```
echo "0 3 * * * root /bin/bash /home/backup/script/sentoraFullBackup.sh" >> /etc/cron.d/sentoraFullBackup
```
<br><br>
## Preparing BackUP server
**1.**Create user:

```
useradd -s /bin/bash -m sentora
su sentora
mkdir /home/sentora/.ssh
mkdir /home/sentora/script
touch /home/sentora/.ssh/authorized_keys
ssh-keygen -b 4096 -N "" -t rsa -f /home/sentora/.ssh/id_rsa
cat /home/sentora/.ssh/id_rsa.pub >> /home/sentora/.ssh/authorized_keys
chmod 700 /home/sentora/.ssh
chmod 600 /home/sentora/.ssh/authorized_keys
chmod 700 /home/sentora
```

**2.**On Sentora server save private key for "sentora" user from backup server
<br>On backup server: ```
cut /home/sentora/.ssh/id_rsa
``` then select key after that copy
<br>On Sentora Server ``` vim /home/backup/script/.ssh/sentora-disk``` paste

**3.**Download script to delete older backup than 7 days

```
cd /home/sentora/script
wget https://raw.githubusercontent.com/dolaravko/LinuxServices/master/Sentora/SentoraFullBackUP/deleteOlderBackUp.sh
chmod +x /home/sentora/script/deleteOlderBackUp.sh
```
**4.**Create cron job ( cron job will run in 1 hours)

```
echo "0 1 * * * root /bin/bash /home/sentora/script/deleteOlderBackUp.sh" >> /etc/cron.d/sentoraDeleteOlderBackUp
```