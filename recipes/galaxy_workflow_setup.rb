#
cookbook_file "create_galaxy_workflowuser.py" do
  path "/tmp/create_galaxy_workflowuser.py"
  action :create_if_missing
end
#
script "galaxy_workflow_setup" do
  environment  ({ "HOME" => "/usr/local/galaxy" })
  interpreter "bash"
  user        "galaxy"
  code <<-EOL
    source /tmp/galaxy_tools/galaxy-mytools_setup-master/.venv/bin/activate ; cd /tmp/galaxy_tools/galaxy-mytools_setup-master/ ; python bit-workflow_install.py $(python /tmp/create_galaxy_workflowuser.py) galaxy
  EOL
  not_if { File.exists?("/usr/local/galaxy/galaxy-dist/workflow_file")}
end
