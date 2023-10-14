#!/bin/bash
# Make by Robert Fil
# 23.01.2021

##### VARIABLES YOU CAN SETUP IN CRONE #####
mode="sftp"
server='192.168.1.15'
port=22
login='test'
PW='test'
dirto='/'
dirfrom=/home/
regex="*.xlsx"
recursivelvl=1
howold="-1"
newname="" # !!!ONLY FOR FTP MODE!!! Used if you wanna add special name for file is use concatenation like $newname-$oldname example "Project-test_123.txt"
#############################################
#########################
findfile=$(find $dirfrom -maxdepth $recursivelvl -name "$regex" -type f -mtime $howold)
echo $findfile



sftp_function() {

# This function is used for sftp

for i in $findfile
          do
          sshpass -p $PW sftp -P $port $login@$server:$dirto <<< $"put $i" #2&1>> /home/rfil/sftp.log.txt
          exit_code=$?
          if [[ $exit_code != 0 ]]; then
                  echo "ERROR of $i transfer to $server" | mail -s "ERROR SFTP TRANSFER from $HOSTNAME to $server" xclinical-sftp-monitoring@xclinical.com
                  logger -t SFTP_LOGS "ERROR of $i transfer to $server"
                  exit 1
          else
                  logger -t SFTP_LOGS "$i transfer to $server DONE"
                  echo "$i"
          fi
          done
          }


ftp_function(){

# This function is used for ftp
# -inp >> /tmp/ftp.good 2>> /tmp/ftp.bad
j=0
for i in $findfile
          do
                    j=$(( $j + 1 ))
                      dirname="`dirname $i`"
                        filename="`basename $i`"
                        newfilename="$newname-`basename $i`"
                          set ssl:check-hostname false
                          set ftp:ssl-protect-data true
                          set ftp:ssl-force true

                          /usr/bin/lftp << EOF
    open $server
    set ftp:ssl-protect-data true
    set ftp:ssl-force true
    login $login $PW
    cd $dirto
    lcd $dirname
    put $filename
    quit
EOF
         done    #end of for iteration
         }
if [[ $mode == "sftp" ]]
then
        sftp_function
elif [[ $mode == "ftp" ]]
then
        ftp_function
else
echo "ERROR"
fi
