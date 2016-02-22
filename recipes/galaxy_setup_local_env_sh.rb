local_env_sh_path = '/usr/local/galaxy/galaxy-dist/config/local_env.sh'
file "#{local_env_sh_path}" do
  content ''
  action :create_if_missing
  notifies :run, "ruby_block[write_environment_values]"
end

ruby_block "write_environment_values" do
  block do
    #
    path = "export PATH=$PATH:/galaxy/Sailfish-0.6.3-Linux_x86-64/bin"
    regexppath = Regexp.escape(path)
    pathfile = Chef::Util::FileEdit.new(local_env_sh_path)
    #pathfile.insert_line_if_no_match(/#{path}/, path)
    pathfile.insert_line_if_no_match(/#{regexppath}/, path)
    pathfile.write_file
    #
    ld_library_path = "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/galaxy/Sailfish-0.6.3-Linux_x86-64/lib"
    regexpld_library_path= Regexp.escape(ld_library_path)
    file = Chef::Util::FileEdit.new(local_env_sh_path)
    #file.insert_line_if_no_match(/#{ld_library_path}/, ld_library_path)
    file.insert_line_if_no_match(/#{regexpld_library_path}/, ld_library_path)
    file.write_file
  end
  action :nothing
  notifies :run, "bash[wait server start after local_env setup]"
end

bash "wait server start after local_env setup" do
  code   "/etc/init.d/galaxy restart ; /usr/local/galaxy/wait_server_started.sh ; sleep 20"
  action :nothing
end
