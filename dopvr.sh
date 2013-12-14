#!/bin/bash

echo "About to do the PVR thing"

/usr/bin/get_iplayer --pvr --output "/home/richard/recordings/" 2>>/tmp/get_iplayer.log

cd /home/richard/recordings

for f in *.m4a; do
  filename=$(basename "$f")
  extension="${filename##*.}"
  filename="${filename%.*}"

  pacpl --eopts="--vbr-new -V 2" --to mp3 $f
  performer=`id3v2 -l $filename.mp3|grep TPE1|cut -d':' -f2-| tr -d [:space:] | tr -d [:punct:]`
  album=`id3v2 -l $filename.mp3|grep TALB|cut -d':' -f2-| tr -d  [:space:] | tr -d [:punct:]`
  title=`id3v2 -l $filename.mp3|grep TIT2|cut -d':' -f2-| tr -d  [:space:] | tr -d [:punct:]`

#  echo $performer
#  echo $album
#  echo $title

  mkdir --parents /home/richard/networkDrive/Multimedia/bbc/$performer/$album
  cp $filename.mp3 /home/richard/networkDrive/Multimedia/bbc/$performer/$album
  mkdir --parents /home/richard/tocopy/bbc/$performer/$album
  mv $filename.mp3 /home/richard/tocopy/bbc/$performer/$album

  mkdir --parents /home/richard/networkDrive/Multimedia/bbcsource/$performer/$album
  mv $filename.m4a /home/richard/networkDrive/Multimedia/bbcsource/$performer/$album

done

echo "Done the PVR thing"
