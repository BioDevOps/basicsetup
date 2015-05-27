#
# Cookbook Name:: basicsetup
# Recipe:: ubuntu_rnsaseqEnv
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
case node['platform']
when "ubuntu"
  package "r-base"
  git "/tmp/ubunturnaseq" do
    repository "https://github.com/myoshimura080822/ubuntu_galaxyEnv_setting.git"
    revision "master"
    notifies :run, "execute[install_ubunturnaseq]"
  end

  execute "install_ubunturnaseq" do
    cwd "/tmp/ubunturnaseq"
    command <<-EOF
chmod 755 setup_rnaseqENV.sh
./setup_rnaseqENV.sh
ps aux | grep galaxy > /tmp/galaxy_restart_before ; /etc/init.d/galaxy restart ; /tmp/wait_server_started.sh ;touch /tmp/galaxy_restart_after_rnaseq_setup_finished; ps aux | grep galaxy > /tmp/galaxy_restart_after
  EOF
    action :nothing
  end

end

include_recipe "basicsetup::galaxy_restart"
bash "wait galaxy server start after rnaseq install" do
  code   "ps aux | grep galaxy > /tmp/galaxy_restart_before2 ; /etc/init.d/galaxy restart ; /tmp/wait_server_started.sh ;touch /tmp/galaxy_restart_after_rnaseq_setup_finished2; ps aux | grep galaxy > /tmp/galaxy_restart_after2"
  action :run
end
