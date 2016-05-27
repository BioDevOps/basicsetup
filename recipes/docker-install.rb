apt_repository "add-docker-repository" do
  uri "https://apt.dockerproject.org/repo"
  distribution node[:basicsetup][:docker][:distribution]
  components ["main"]
  keyserver 'hkp://p80.pool.sks-keyservers.net:80'
  key "58118E89F3A912897C070ADBF76221572C52609D"
  action :add
  notifies :run, "bash[apt-get update]"
end

bash "apt-get update" do
  code   "apt-get update"
  action :nothing
  notifies :create, "docker_installation_package[default]"
end

docker_installation_package 'default' do
  version node[:basicsetup][:docker][:version]
  #action :create
  action :nothing
  package_options %q|--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'| # if Ubuntu for example
  notifies :modify, "group[docker]"
end

group 'docker' do
  action :nothing
  members node[:basicsetup][:docker][:members]
  append true
  only_if { node[:basicsetup][:docker][:setup_group] }
end
