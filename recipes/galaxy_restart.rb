#
# Cookbook Name:: basicsetup
# Recipe:: galaxy_restart
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
# TODO /tmp/wait_galaxy_server_start.sh is come from galaxy recipe.
bash "wait_galaxy_server_start" do
  code   "/etc/init.d/galaxy restart ; /tmp/wait_server_started.sh"
  action :run
end
