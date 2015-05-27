#
# Cookbook Name:: basicsetup
# Recipe:: infrasetup_directory
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
#
#
directory "/usr/local/galaxy/bit_tools" do
  owner "galaxy"
  group "galaxy"
  mode 00755
  action :create
  recursive true
end
#
directory "/usr/local/galaxy/import_data" do
  owner "galaxy"
  group "galaxy"
  mode 00755
  action :create
  recursive true
end

# restart data directory setup
# wait_server_started.sh setup by galaxy
# TODO: this file goes to galaxy recipe ?
bash "wait server start after data directory setup" do
  code   "/etc/init.d/galaxy restart ; /tmp/wait_server_started.sh"
  action :run
end
