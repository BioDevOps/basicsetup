#
# Cookbook Name:: basicsetup
# Recipe:: galaxy_setup
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
# install directory
install_dir="/tmp/galaxy_tools"
directory "#{install_dir}" do
  owner "galaxy"
  group "galaxy"
  mode 00755
  action :create
end

# download zip file to /tmp
remote_file "#{Chef::Config[:file_cache_path]}/galaxy_tools.zip" do
  source "https://github.com/myoshimura080822/galaxy-mytools_setup/archive/master.zip"
end

# extract galaxy
script "extract_galaxy_setup" do
  interpreter "bash"
  user        "galaxy"
  code <<-EOL
    install -d #{install_dir}
    unzip "#{Chef::Config[:file_cache_path]}/galaxy_tools.zip" -d #{install_dir}
  EOL
  not_if { File.exists?("/tmp/galaxy_tools/galaxy-mytools_setup-master")}
end
# TODO restart galaxy
bash "wait server start for install galaxy tools to galaxy" do
  code   "/etc/init.d/galaxy restart ; /tmp/wait_server_started.sh"
  action :run
end

# /tmp/galaxy_tools/galaxy-mytools_setup-master
script "pip_virtualenv_galaxy_setup" do
  environment  ({ "HOME" => "/usr/local/galaxy" })
  interpreter "bash"
  user        "galaxy"
  code <<-EOL
    virtualenv /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv
    source /etc/profile ; source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ;env > /tmp/env_activate_and_etc_profile.out; pip list > /tmp/pip.list
    source /etc/profile ; source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ;env > /tmp/env.out; pip install pyyaml ; pip install bioblend ; cd /tmp/galaxy_tools/galaxy-mytools_setup-master/install_toolshed_tools/ ; python install_toolshed_tools.py galaxy
    source /etc/profile ; source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ; pip install grequests ; pip install gitpython
    source /etc/profile ; source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ;  cd /tmp/galaxy_tools/galaxy-mytools_setup-master/ ; python bit-tools_install.py galaxy
    source /etc/profile ; source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ;  cd /tmp/galaxy_tools/galaxy-mytools_setup-master/setup_reference_and_index ; python setup_sailfish_in_Galaxy.py index_file_list.txt galaxy

  EOL




  # source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ; pip install grequests ; pip install gitpython ; cd /tmp/galaxy_tools/galaxy-mytools_setup-master/setup_sailfish_index/ ; export LD_LIBRARY_PATH=/usr/local/src/Sailfish-0.6.3-Linux_x86-64/lib:$LD_LIBRARY_PATH ; export PATH=/usr/local/src/Sailfish-0.6.3-Linux_x86-64/bin:$PATH ; python setup_sailfish_in_Galaxy.py  index_file_list.txt galaxy
  not_if { File.exists?("/tmp/galaxy_tools/galaxy-mytools_setup-master/.venv")}
end
# pip install for galaxy environment
#script "pip_install_for_galaxy_environment" do
#  interpreter "bash"
#  user        "galaxy"
#  code <<-EOL
#    source /usr/local/galaxy/galaxy-dist/.venv/bin/activate ; pip install python-dateutil ; pip install bioblend  ; pip install pandas ; pip install grequests ; pip install GitPython
#    date
#  EOL
#  # source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ; pip install grequests ; pip install gitpython ; cd /tmp/galaxy_tools/galaxy-mytools_setup-master/setup_sailfish_index/ ; export LD_LIBRARY_PATH=/usr/local/src/Sailfish-0.6.3-Linux_x86-64/lib:$LD_LIBRARY_PATH ; export PATH=/usr/local/src/Sailfish-0.6.3-Linux_x86-64/bin:$PATH ; python setup_sailfish_in_Galaxy.py  index_file_list.txt galaxy
#  #not_if { File.exists?("/tmp/galaxy_tools/galaxy-mytools_setup-master/.venv")}
#end

# # restart after bit tool install
# bash "wait server start after bit tool install" do
#   code   "/etc/init.d/galaxy restart ; /tmp/wait_server_started.sh"
#   action :run
# end
# # /tmp/galaxy_tools/galaxy-mytools_setup-master
# script "create_sailfish_index" do
#   interpreter "bash"
#   user        "galaxy"
#   code <<-EOL
#      #source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ; cd /tmp/galaxy_tools/galaxy-mytools_setup-master/setup_reference_and_index/ ; export LD_LIBRARY_PATH=/usr/local/src/Sailfish-0.6.3-Linux_x86-64/lib:$LD_LIBRARY_PATH ; export PATH=/usr/local/src/Sailfish-0.6.3-Linux_x86-64/bin:$PATH ; python setup_sailfish_in_Galaxy.py  index_file_list.txt galaxy
#   EOL
#   #not_if { File.exists?("/usr/local/galaxy/bit_tools/sailfish")}
# end
