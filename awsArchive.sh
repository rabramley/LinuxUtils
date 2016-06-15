#!/usr/bin/env bash

UPLOAD_DIR=/mnt/nas/PhotosAndVideos/
S3_BUCKET=s3://richard.bramley.archive/PhotosAndVideos/
LOGFILE=/var/log/s3archive.log

echo Starting archiving at `date` >$LOGFILE
echo Run by `id -u -n` >> $LOGFILE

while true
do
    if mountpoint -q /mnt/nas
        then
            echo "Mount located" >> $LOGFILE
            nice trickle -s -u 32 /usr/local/bin/aws s3 sync $UPLOAD_DIR $S3_BUCKET --exclude ".*" --exclude "*/.*" --no-follow-symlinks --size-only >>$LOGFILE 2>>$LOGFILE &
            echo "Job Started" >> $LOGFILE
            break
        fi
    echo "Waiting for mount ..." >> $LOGFILE
    sleep 10
done



