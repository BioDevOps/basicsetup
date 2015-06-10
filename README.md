# basicsetup
basic machine setup cookbook

# Prerequisite for vagrant
```
vagrant plugin install vagrant-chef-zero
vagrant plugin install vagrant-omnibus
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

### Time to setup using vagrant

When I executed ***vagrant up*** , it tooks 1.5 hour.
It does not need to any interaction.
Just type command and wait.

I think most of time takes to download compressed(gzip) sailfish index (11G)
and extract it.

I test it with the VM which is assigned 2 CPU and 8GB RAM.
I write these assignment to Vagrantfile.

#### sailfish index create by execute sailfish command.

If you have enough resource, you can choose the method of create sailfish index
 via sailfish command.

## TODO

see [TODO]

# License

Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
Released under the [Apache2 license]
