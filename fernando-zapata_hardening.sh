#/bin/bash
#Author: Fernando Zapata Robles
#22/11/2021
#version: 2.0

#Scan OS
echo "Scanning OS..."
cat /etc/os-release | egrep ^'NAME='
cat /etc/os-release | egrep ^'VERSION='
sleep 3

#Check and remove old version of clamav
if yum list -q installed *clamav*
then
        if systemctl status clamav-daemon
        then
                sudo systemctl stop clamav-daemon
        fi
        echo "Removing clamav..."
        sudo yum -q -y remove *clamav*
fi
#Install EPEL and clamav

if cat /etc/os-release | egrep 'VERSION="7"'
then
        if yum list -q installed *epel*
        then
                echo "EPEL is alredy installed"
        else
                echo "Installign EPEL..."
                sleep 3
                sudo yum -y install epel-release
                sleep 1
                sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd

        fi
else
        echo "centOs8"
        sleep 1
        if yum -q list installed *wget*
        then
                echo "clamav is alredy installed"
        else
                echo "installing wget..."
                sudo yum install -y wget
        fi
        sleep 1
        sudo yum -y install epel-release > /dev/null
        sleep 1
        sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
        sudo yum remove -y epel-release >/dev/null


fi

#Update
yum -y update
