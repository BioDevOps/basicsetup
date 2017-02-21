
template '/lib/systemd/system/docker-galaxy.service' do
  source 'docker-galaxy.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :nothing
  notifies :run, "bash[enable-docker-galaxy]"
  subscribes :create_if_missing, "template[/usr/local/galaxy-bitwf/scripts/2790.diff]", :immediately
end

# enable docker-galaxy service
bash "enable-docker-galaxy" do
  code   "sudo systemctl enable docker-galaxy"
  action :nothing
  notifies :run, "bash[start-docker-galaxy]"
end
# start docker-galaxy service
bash "start-docker-galaxy" do
  code   "sudo systemctl start docker-galaxy ; sleep 10  ; /usr/local/galaxy-bitwf/scripts/wait_docker_server_started.sh ;  sleep 10"
  action :nothing
end
