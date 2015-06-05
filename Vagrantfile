# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.name = "bayesvm_20150605_1"
    v.customize ["modifyvm", :id, "--memory", "8192", "--cpus", "4"]
  end

  config.vm.network "private_network", ip: "192.168.33.51"
  config.omnibus.chef_version=:latest
  config.chef_zero.chef_repo_path = "."
  config.vm.box = "box80g"
  config.vm.box_url = "http://q-brain.riken.jp/vm/box80g.box"
  config.vm.provision :chef_client do |chef|
    chef.custom_config_path = "chef_custom_config"
    chef.run_list = [
        "ubuntu-change-source-list",
        "apt",
        "java",
        "timezone-ii",
        "basicsetup",
        "postgresql::server",
        "postgresql::client",
        "apache2",
        "apache2::mod_authz_host",
        "apache2::mod_access_compat",
        "apache2::mod_proxy",
        "apache2::mod_proxy_http",
        "galaxy@0.6.9",
        "galaxy-httpproxy@0.3.1",
        "basicsetup::setup_galaxy_directory",
        "basicsetup::sailfish_index_download",
        "basicsetup::Rinstall",
        "basicsetup::ubuntu_rnsaseqEnv",
        "basicsetup::galaxy_setup",
        "basicsetup::med-bio-install",
        "basicsetup::createmachineadminuser"
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
        :jdk_version => '7'
      },
      :ubuntu => {
        :mirror_site_url => "http://ftp.jaist.ac.jp/pub/Linux/ubuntu/",
        :version => "14.04",
        :need_deb_src => false,
        :need_update => true
      },
      :postgresql => {
        :password => {
          :postgres => "galaxy"
        }
      },
      :galaxy_http_proxy => {
        :galaxy_conf => "apache.2.4.galaxy.conf.erb"
      },
      :galaxy => {
        :user => "galaxy",
        :group => "galaxy",
        :admin_users => "test@example.com",
        :master_api_key => "changeit",
        :overwrite_run_sh => true,
        :overwrite_fetch_eggs_py => true,
        :tool_dependency_dir => "./tool_dependency_directory",
        :library_import_dir => "/usr/local/galaxy/import_data",
        :home => "/usr/local/galaxy",
        :reference => "latest_2014.08.11",

        :db => {
          :type => "postgresql",
          :hostname => "127.0.0.1",
          :databasename => "galaxy",
          :databaseusername => "galaxy",
          :databasepassword => "galaxy",
          :admin => {
            :username => "postgres",
            :password => "galaxy"
          }
        }
      }
    }
  end
end
