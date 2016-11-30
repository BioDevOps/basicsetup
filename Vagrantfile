# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.name = "bayesvm_1.3.0-dev-20161003"
    v.customize ["modifyvm", :id, "--memory", "8192", "--cpus", "4"]
  end
  config.ssh.insert_key = false
  config.vm.network "private_network", ip: "192.168.33.51"
  #config.omnibus.chef_version=:latest
  config.omnibus.chef_version="12.7.2"
  config.chef_zero.chef_repo_path = "."
  config.vm.box = "ubuntu1604_80G"
  config.vm.box_url = "https://q-brain2.riken.jp/vm/ubuntu1604_80G.box"
  config.vm.provision :chef_client do |chef|
    chef.custom_config_path = "chef_custom_config"
    chef.run_list = [
#"basicsetup::change-apt",
"ubuntu-change-source-list",
"apt",
"java",
"timezone-ii",
"basicsetup",
"basicsetup::med-bio-install",
"basicsetup::docker-install"


    ]
    chef.json = {
      :apt => {
        :compile_time_update => true
      },
      :basicsetup => {
        :sailfish => {
          :index => {
            :create_method => "download"
          }
        }
      },
      :"build-essential" => {
        :compile_time => true
      },
      :tz => "Asia/Tokyo",
      :java => {
        :install_flavor => "openjdk",
        :jdk_version => '8'
      },
      :ubuntu => {
        :mirror_site_url => "http://ftp.jaist.ac.jp/pub/Linux/ubuntu/",
        :version => "16.04",
        :need_deb_src => false,
        :need_update => true
      }
    }
  end
end
