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
vagrant up
```

## If you have some error message.

Sometimes it fails some reason(mostly network problem I think).

```
vagrant provision
```

I'll hope to fix it and robust to finish the cookbooks.

### I want to change recipe




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
## bioconda

### First time

Create conda environment and install `bwa`

```
conda create -n myenvironment bwa=0.7.12
source activate myenvironment
bwa
```

### Remove tool

```
conda remove -n myenvironment bwa
```

### Remove conda environment

```
conda env remove -n myenvironment
```

### Anaconad Documentation

* [Anaconda Distribution | Continuum Analytics: Documentation](https://docs.continuum.io/anaconda/)

## TODO

see [TODO](TODO.md)

# License

Copyright (c) [2015-2016] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
Released under the [Apache License Version 2.0]
