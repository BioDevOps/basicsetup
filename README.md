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
Vagrant 1.6.5
```

vagrant plugins version are

```
vagrant-chef-zero (1.0.1)
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

## TODO

see [TODO](TODO.md)

# License

Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
Released under the [Apache License Version 2.0]
