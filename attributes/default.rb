    default[:basicsetup][:admin][:user]      = "biouser"
    default[:basicsetup][:admin][:uid]      = 5000
    #
    # default password 'biouser'
    #
    default[:basicsetup][:admin][:password]     = "$1$ZhaotFMK$.aZnr3U.ijnfj9Z/AtuD60"
    #
    # biouser can sudo with password.
    #
    default[:basicsetup][:admin][:sudonopassword]      = false

    default[:basicsetup][:admin][:group]      = "biouser"
    default[:basicsetup][:admin][:gid]      = 5000

    default[:basicsetup][:admin][:home]      = "/home/"+default[:basicsetup][:admin][:user]
    default[:basicsetup][:admin][:shell]      = "/bin/bash"

# sailfish
default[:basicsetup][:sailfish][:index][:create_method] = "executecommand"
default[:basicsetup][:sailfish][:index][:download][:filename] = "sailfish_index_20150529.tar.gz"
default[:basicsetup][:sailfish][:index][:download][:url]="http://q-brain2.riken.jp/vm/sailfish_index_20150529.tar.gz"

# docker version
default[:basicsetup][:docker][:distribution]="ubuntu-xenial"
default[:basicsetup][:docker][:version]='1.11.1'
default[:basicsetup][:docker][:setup_group]=true
default[:basicsetup][:docker][:members]='vagrant'

# galaxy related
default[:basicsetup][:galaxy][:user]='vagrant'
default[:basicsetup][:galaxy][:group]='vagrant'
