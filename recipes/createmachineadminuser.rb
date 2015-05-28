#
# Cookbook Name:: basicsetup
# Recipe:: createmachineadminuser
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
if node[:basicsetup][:admin][:user]
    group node[:basicsetup][:admin][:group] do
        group_name node[:basicsetup][:admin][:group]
        gid node[:basicsetup][:admin][:gid]
    end
    user node[:basicsetup][:admin][:user] do
        uid node[:basicsetup][:admin][:uid]
        gid node[:basicsetup][:admin][:gid]
        password node[:basicsetup][:admin][:password]
        home node[:basicsetup][:admin][:home]
        shell node[:basicsetup][:admin][:shell]
        supports :manage_home => true
        action   :create
    end
    sudo 'machineadmin' do
        user node[:basicsetup][:admin][:user]
        nopasswd node[:basicsetup][:admin][:sudonopassword]
    end
end
