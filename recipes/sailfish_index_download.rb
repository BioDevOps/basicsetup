#
# Cookbook Name:: basicsetup
# Recipe:: sailfish_index_download
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#

# download generated index or execute sailfish command
# cd /usr/local/galaxy/bit_tools/ ; wget "http://q-brain.riken.jp/vm/sailfish_index_20150529.tar.gz" -O - | tar zxvf -
sailfish_index_command="touch /tmp/sailfish.txt"
sailfish_index_create_method = node[:basicsetup][:sailfish][:index][:create_method]
if sailfish_index_create_method == "executecommand"
  #sailfix_index_command = "source /etc/profile ; source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ;  cd /tmp/galaxy_tools/galaxy-mytools_setup-master/setup_reference_and_index ; python setup_sailfish_in_Galaxy.py index_file_list.txt galaxy"
  sailfish_index_command = "touch /tmp/sailfishexecutecommand.txt"
elsif sailfish_index_create_method == "download"
  
  #sailfish_index_command = "touch /tmp/sailfishdownload.txt"
  sailfish_index_command = "wget http://q-brain.riken.jp/vm/sailfish_index_20150529.tar.gz -O - | tar zxvf - -C /usr/local/galaxy/bit_tools/"
else
  sailfish_index_command = "touch /tmp/nevermatch.txt"
end
script "sailffish_index_create" do
  environment  ({ "HOME" => "/usr/local/galaxy" })
  interpreter "bash"
  user        "galaxy"
  code <<-EOL
    #{sailfish_index_command}
    echo "#{sailfish_index_create_method}" > /tmp/method
  EOL
  action :run
  not_if { File.exists?("/usr/local/galaxy/bit_tools/sailfish_index/")}
end
