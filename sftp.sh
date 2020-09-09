#!/bin/bash
# Make by Robert Fil
# 09.09.2020

server=0.0.0.0
port=22
login=user
PW='passwd'
dirto=/home/user
dirfrom=/home/user
regex="*.txt"
recursivelvl=1
howold="-60"
findfile=$(find $dirfrom -maxdepth $recursivelvl -name "$regex" -type f -mtime $howold)
echo $findfile
for i in $findfile
          do
          sshpass -p $PW sftp -P $port $login@$server:$dirto <<< $"put $i"
          done
