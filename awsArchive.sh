#!/usr/bin/env bash

LOGFILE=/var/log/s3archive.log

echo Starting archiving at `date` >$LOGFILE
echo Run by `id -u -n` >> $LOGFILE

while true
do
    if mountpoint -q /mnt/nas
        then
            echo "Mount located" >> $LOGFILE
            break
        fi
    echo "Waiting for mount ..." >> $LOGFILE
    sleep 10
done

nice trickle -s -u 32 /usr/local/bin/aws s3 sync /mnt/nas/TBD_TestAwsArchive/ s3://richard.bramley.sandbox/ --exclude ".*" --exclude "*/.*" --no-follow-symlinks --size-only >>$LOGFILE 2>>$LOGFILE &


