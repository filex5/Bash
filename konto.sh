#!/bin/bash

for i in {1..10}
do

newuser=user$i
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
 
# Tworzenie Userow z randomowym hasłem.
 
useradd $newuser
echo $newuser:$randompw | chpasswd
echo "UserID:" $newuser "Haslo:" $randompw >>account.txt
echo "UserID:" $newuser "Haslo:" $randompw

done
