#!/bin/bash

for i in {0..10}
do
newuser=user$i
 
# Usuwa userow zrobionych poprzednim skryptem.
 
userdel $newuser
echo "UserID:" $newuser "has been deleted" 
done
