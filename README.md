# basicsetup
basic machine setup cookbook

# Prerequisite for vagrant

```
vagrant plugin install vagrant-chef-zero
vagrant plugin install vagrant-omnibus
```

## Our develop environment

virtualbox

vagrant version is

```
$ vagrant -v
Vagrant 1.8.5
```

vagrant plugins version are

```
vagrant-chef-zero (2.0.0)
vagrant-omnibus (1.4.1)
```

# Setup using vagrant

```
berks vendor cookbooks
vagrant up --provision
```

## If you have some error message.

Sometimes it fails some reason(mostly network problem I think).

```
vagrant provision
```

I'll hope to fix it and robust to finish the cookbooks.

### I want to change recipe

apt-get -q -y --force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all' install docker-engine=1.12.3-0~trusty


### How long does it take to setup using vagrant

When I executed ***vagrant up*** , it tooks 1.5 hour.
It does not need to any interaction.
Just type command and wait.

I think most of time takes to download compressed(gzip) sailfish index (11G)
and extract it.

I test it with the VM which is assigned 4 CPU and 8GB RAM.
I write these assignment to Vagrantfile.

#### sailfish index create by execute sailfish command.

If you have enough resource, you can choose the method of create sailfish index
 via sailfish command.


# FAQ

## Sometimes job is fail.

Answer. Maybe machine resource is not enought to execute.

Almost case is that RAM is not enough.

HISAT2 require some times 32GB.

or

You try to run some jobs parallel.


## Recreate

```
vagrant halt
VBoxManage sharedfolder remove bayesvm_1.3.0  --name vagrant
VBoxManage export bayesvm_1.3.0 -o bayesvm_1.3.0-dev.ova
```

## Galaxy

### How does Galaxy runs ?

* Galaxy run in docker
* Galaxy run with systemctl
* Galaxy starts on boot by default setting
* Galaxy using port 28080, 29002

### I can't access .

Galaxy is available port 28080.

http://localhost:28080
or
http://yourbayeslinuxhost:28080

#### How to change Galaxy port 28080 to 80

1. Check port 80 is used or not.
1. If port 80 is used, stop the service.
1. Change port 28080 to 80 by editing `/usr/local/galaxy-bitwf/scripts/start_bitwf.sh`. `-p 28080:80` to `-p 80:80`

#### Why Galaxy default port is 28080 ?

To avoid conflict with other application.

Port 80 is using by httpd server (Apache httpd , Nginx is famous )

### Start Galaxy

#### 14.04

```
sudo /etc/init.d/docker-galaxy start
```

### Stop Galaxy

#### 14.04

```
sudo /etc/init.d/docker-galaxy stop
```

### Where is setting files.

* service

```
/lib/systemd/system/docker-galaxy.service
```

* Start script

```
/usr/local/galaxy-bitwf/scripts/start_bitwf.sh
```

* Stop script

```
/usr/local/galaxy-bitwf/scripts/stop_bitwf.sh
```

### Other directories and files structure.

Run Galaxy following directory

```
/usr/local/galaxy-bitwf/scripts
```

#### -v files

|In host|In docker container|File or Directory|Note|
|:---|:---|:---:|:---|
|/usr/local/galaxy-bitwf/scripts|/usr/local/galaxy-bitwf/scripts|directory|for share|
|/usr/local/galaxy-bitwf/scripts/2790.diff|/galaxy-central/2790.diff|file|Galaxy pull 2790 diff|
|/usr/local/galaxy-bitwf/scripts/job_conf.xml|/etc/galaxy/job_conf.xml|file|Job setting|
|/usr/local/galaxy-bitwf/export|/export|directory|for share|
|/usr/local/galaxy-bitwf/data|/data|directory|for share Readonly|
|/usr/local/galaxy-bitwf/scripts/setup_inside_container.sh|/galaxy-central/setup_inside_container.sh|file|Startup script|

* Detail [templates/start_bitwf.sh.erb](./templates/start_bitwf.sh.erb)

* [More configurability for containerized jobs by jmchilton · Pull Request #2790 · galaxyproject/galaxy](https://github.com/galaxyproject/galaxy/pull/2790)

* [2790.diff](https://patch-diff.githubusercontent.com/raw/galaxyproject/galaxy/pull/2790.diff)

### NFS and docker

If you using NFS for data persistent,
 you need to care about order of NFS mount and docker galaxy start.

NFS needs to mount before docker galaxy start.

#### To check mount is success

This case `/data` is on NFS

```
docker exec galaxy_bitwf_1.3.0 ls /data
```

If there is no data , it fail to start.
To resolve problem

```
sudo /etc/init.d/docker-galaxy stop
docker rm galaxy_bitwf_1.3.0
sudo /etc/init.d/docker-galaxy start
```

#### Not start docker-galaxy at boot time

If you want to start docker-galaxy , you need to disable automatic start on boot.

```
sysv-rc-conf docker-galaxy off
```

## bioconda

### First time

Create conda environment and install `bwa`

```
conda create -n myenvironment bwa=0.7.12
source activate myenvironment
bwa
```

### list conda envrionment

```
conda info -e
```

## list conda channels

```
conda config --get channels
conda config --get channels --system
```

### Remove tool

```
conda remove -n myenvironment bwa
```

### Remove conda environment

```
conda env remove -n myenvironment
```

### Anaconda Documentation

* [Anaconda Distribution | Continuum Analytics: Documentation](https://docs.continuum.io/anaconda/)

## TODO

see [TODO](TODO.md)

# License

Copyright (c) [2015-2017] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
Released under the [Apache License Version 2.0]
