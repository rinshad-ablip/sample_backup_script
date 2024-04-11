#!/bin/bash

# set variables for remote server
REMOTE_USER="remote_user"
REMOTE_HOST="remote.host.com"
REMOTE_DIR="/path/to/backup/folder"

# set variables for database backup
DB_USER="database_user"
DB_PASS="database_password"
DB_NAME="database_name"

# set variables for local backup
LOCAL_DIR="/path/to/local/backup/folder"
BACKUP_NAME="$(date +%Y%m%d%H%M%S)_backup.tar.gz"

# create backup folder on local machine
mkdir -p $LOCAL_DIR

# ssh into remote server and create backup archive
ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_DIR && tar czf - $DB_NAME.sql | gzip -c" > $LOCAL_DIR/$BACKUP_NAME

# take database backup
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $LOCAL_DIR/$DB_NAME.sql

# compress the database backup
gzip $LOCAL_DIR/$DB_NAME.sql

echo "Backup completed successfully"
