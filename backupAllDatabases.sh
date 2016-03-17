#! /bin/bash
 
if [[ $1 == D ]]; then
    BACKUP_PERIOD="daily"
    REMOVE_TIMESPAN_DAYS=+7
elif [[ $1 == W ]]; then
    BACKUP_PERIOD="weekly"
    REMOVE_TIMESPAN_DAYS=+30
elif [[ $1 == M ]]; then
    BACKUP_PERIOD="monthly"
    REMOVE_TIMESPAN_DAYS=+130
else
    echo "Time period parameter not supplied should be D, W or M"
    exit 1
fi

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/local/backup/$BACKUP_PERIOD"
MYSQL_USER="lampuser"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="PeRin1"
MYSQLDUMP=/usr/bin/mysqldump
 
mkdir -p "$BACKUP_DIR"
 
databases=`$MYSQL -S /db/mysql/mysql.sock --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
for db in $databases; do
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases -S /db/mysql/mysql.sock $db | gzip > "$BACKUP_DIR/$db-$TIMESTAMP.gz"
done

find $BACKUP_DIR -ctime $REMOVE_TIMESPAN_DAYS -exec rm {} +