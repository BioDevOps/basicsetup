#
cookbook_file "recipe_galaxy.sh" do
  path "/usr/local/galaxy/recipe_galaxy.sh"
  mode '0755'
  action :create_if_missing
end
#
cookbook_file "recipe_bit_wf_install.sh" do
  path "/usr/local/galaxy/recipe_bit_wf_install.sh"
  mode '0755'
  action :create_if_missing
end
#
cookbook_file "recipe_root.sh" do
  path "/usr/local/galaxy/recipe_root.sh"
  mode '0755'
  action :create_if_missing
end
#
cookbook_file "local-install-repository.sh" do
  path "/usr/local/galaxy/local-install-repository.sh"
  mode '0755'
  action :create_if_missing
end
#
package "expect"
cookbook_file "/usr/local/galaxy/wait_server_started.sh" do
  source "wait_server_started.sh"
  owner node[:galaxy][:user]
  group node[:galaxy][:group]
  mode "0755"
  action :create_if_missing
end
#
#
script "recipe_root" do
  interpreter "bash"
  code "/usr/local/galaxy/recipe_root.sh &> /usr/local/galaxy/recipe_root.out"
  action :run
  notifies :run, "bash[wait server start]"
end

# wait server start

bash "wait server start" do
  action :nothing
  code   "/etc/init.d/galaxy restart ; /usr/local/galaxy/wait_server_started.sh ; sleep 20"
  notifies :run, "script[recipe_galaxy]"
end

script "recipe_galaxy" do
  user "galaxy"
  group "galaxy"
  environment  ({ "HOME" => "/usr/local/galaxy" })
  interpreter "bash"
  code "sleep 20 ; /usr/local/galaxy/recipe_galaxy.sh &> /usr/local/galaxy/recipe_galaxy.out"
  action :nothing
  action :run
  notifies :run, "bash[wait server start before bit wf install]"
end

bash "wait server start before bit wf install" do
  code   "/etc/init.d/galaxy restart ; /usr/local/galaxy/wait_server_started.sh ; sleep 20"
  action :nothing
  notifies :run, "script[recipe_bit_wf_install]"
end

script "recipe_bit_wf_install" do
  user "galaxy"
  group "galaxy"
  environment  ({ "HOME" => "/usr/local/galaxy" })
  interpreter "bash"
  code "/usr/local/galaxy/recipe_bit_wf_install.sh &> /usr/local/galaxy/recipe_bit_wf_install.out"
  action :nothing
end
