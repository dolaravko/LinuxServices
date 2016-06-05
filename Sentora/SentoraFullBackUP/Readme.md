# Sentora Full BackUP


## Preparing Sentora server

1. Install xtrabackup [percona xtrabackup](https://www.percona.com/doc/percona-xtrabackup/2.4/installation/apt_repo.html)<br>
On Sentora server (Ubuntu):<br>

```
wget https://repo.percona.com/apt/percona-release_0.1-3.$(lsb_release -sc)_all.deb

sudo dpkg -i percona-release_0.1-3.$(lsb_release -sc)_all.deb

sudo apt-get update

sudo apt-get install percona-xtrabackup-24
```

2. Create folder for backup on Sentora server<br>

```
mkdir  -p /home/backup
```

3. Create folder for mysql backup and script folder on Sentora server<br>

```
mkdir  -p /home/backup/mysql
mkdir  -p /home/backup/script
```

4. Put script on folder<br>```vim /home/backup/script/sentoraFullBackup.sh```

