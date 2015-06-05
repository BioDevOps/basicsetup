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
