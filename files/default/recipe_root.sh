#!/bin/bash

# s0
mkdir /data
mount -t nfs 192.168.99.1:/ /data

#root@default-ubuntu-1404:~# dd if=/data/test.dd of=/tmp/test.dd bs=100K count=1000
#1000+0 records in
#1000+0 records out
#102400000 bytes (102 MB) copied, 0.609543 s, 168 MB/s
#root@default-ubuntu-1404:~# nfsstat -m
#/data from 192.168.99.1:/
# Flags:	rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.99.102,local_lock=none,addr=192.168.99.1

# s1
mkdir -p /export
chmod 777 /export
ln -s /usr/local/galaxy/galaxy-dist /export/galaxy-central
ln -s /usr/local/galaxy/galaxy-dist /galaxy-central
ln -s /usr/local/galaxy/shed_tools /


# s2
mkdir /galaxy
chown galaxy:galaxy /galaxy

# s3
mkdir -p /galaxy-central/config/import_data
chown galaxy:galaxy /galaxy-central/config/
chown galaxy:galaxy /galaxy-central/config/import_data
cd /galaxy-central/config/import_data
ln -s /data/transcriptome_ref_fasta
ln -s /data/adapter_primer
ln -s /data/quartz_div100_rename

# s4
apt-get update
apt-get -y upgrade
apt-get -y install tree zsh imagemagick pandoc libcurl4-gnutls-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev software-properties-common git
add-apt-repository 'deb http://cran.us.r-project.org/bin/linux/ubuntu trusty/'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update
apt-get install -y --force-yes r-base=3.2.2* r-base-dev=3.2.2* r-recommended=3.2.2*
apt-get install -y --force-yes libcurl4-openssl-dev libxml2-dev libxt-dev libgtk2.0-dev libcairo2-dev xvfb xauth xfonts-base mesa-common-dev libx11-dev freeglut3-dev openjdk-7-jre-headless

# s6
wget https://raw.githubusercontent.com/myoshimura080822/galaxy_in_docker_custom/master/install_rnaseqENV.R -O /galaxy/install_rnaseqENV.R
R -e 'source("/galaxy/install_rnaseqENV.R")'
# maybe install under .venv
pip install python-dateutil
pip install bioblend
pip install pandas
pip install grequests
pip install GitPython
pip install pip-tools

/etc/init.d/galaxy restart
