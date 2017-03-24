# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.name = "bayesvm_1.3.0-20170324"
    v.customize ["modifyvm", :id, "--memory", "8192", "--cpus", "4"]
  end
  config.ssh.insert_key = false
  config.vm.network "private_network", ip: "192.168.33.51"
  #config.omnibus.chef_version=:latest
  config.omnibus.chef_version="12.7.2"
  config.chef_zero.chef_repo_path = "."
  config.vm.box = "box80g"
  config.vm.box_url = "https://q-brain2.riken.jp/vm/box80g.box"
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
"basicsetup::docker-install",
"anaconda::default",
"anaconda::shell_conveniences",
"basicsetup::bioconda_install"
    ]
    chef.json = {
      :anaconda => {
        :flavor => 'x86_64',
        :accept_license => 'yes'
      },
      :apt => {
        :compile_time_update => true
      },
      :basicsetup => {
        :docker => {
          :version => '1.12.3',
          :distribution => 'ubuntu-trusty'
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
        :version => "14.04",
        :need_deb_src => false,
        :need_update => true
      }
    }
  end
end
