#!/bin/bash

#     AUTOMATYCZNIE UPDATUJE REPOZYTORIA ORAZ SYSTEM

RED="\e[0;31m"

function auto_update()
{
sudo apt-get update 
sudo apt-get upgrade -y
echo -e "${RED} SYSTEM ZAOSTAL ZAKTUALIZOWANY"
}

auto_update