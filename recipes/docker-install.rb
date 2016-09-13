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
  notifies :pull, "docker_image[myoshimura080822/galaxy_in_docker_bitwf]"
end

docker_image 'myoshimura080822/galaxy_in_docker_bitwf' do
  tag '160607'
  action :nothing
  notifies :create_if_missing, "template[/lib/systemd/system/docker-galaxy.service]"
end

template '/lib/systemd/system/docker-galaxy.service' do
  source 'docker-galaxy.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :nothing
  notifies :run, "bash[enable-docker-galaxy]"
end

# enable docker-galaxy service
bash "enable-docker-galaxy" do
  code   "sudo systemctl enable docker-galaxy"
  action :nothing
  notifies :run, "bash[start-docker-galaxy]"
end
# start docker-galaxy service
bash "start-docker-galaxy" do
  code   "sudo systemctl start docker-galaxy"
  action :nothing
end

# create directory for galaxy bit workflow
bash "create_directories_for_bitwf" do

  code <<-EOH
mkdir -p /usr/local/galaxy-bitwf
cd /usr/local/galaxy-bitwf
mkdir -p scripts
mkdir -p data/transcriptome_ref_fasta
mkdir -p data/adapter_primer
mkdir -p data/Homo_sapiens_genome
mkdir -p data/Mus_musculus_genome
mkdir -p export/postgresql/
chmod 777 -R export
chown -R vagrant:vagrant /usr/local/galaxy-bitwf
  EOH
  action :run
  not_if { ::File.exists?("/usr/local/galaxy-bitwf") }
  notifies :create_if_missing, "template[/usr/local/galaxy-bitwf/scripts/setup_inside_container.sh]"
end

template '/usr/local/galaxy-bitwf/scripts/setup_inside_container.sh' do
  source 'setup_inside_container.sh.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :nothing
  notifies :create_if_missing, "template[/usr/local/galaxy-bitwf/scripts/start_bitwf.sh]"
end
template '/usr/local/galaxy-bitwf/scripts/start_bitwf.sh' do
  source 'start_bitwf.sh.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :nothing
  notifies :create_if_missing, "template[/usr/local/galaxy-bitwf/scripts/stop_bitwf.sh]"
end
template '/usr/local/galaxy-bitwf/scripts/stop_bitwf.sh' do
  source 'stop_bitwf.sh.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :nothing
  notifies :create_if_missing, "template[/usr/local/galaxy-bitwf/scripts/job_conf.xml.local]"
end
template '/usr/local/galaxy-bitwf/scripts/job_conf.xml.local' do
  source 'job_conf.xml.local.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
  action :nothing
  notifies :create_if_missing, "template[/usr/local/galaxy-bitwf/scripts/2790.diff]"
end
template '/usr/local/galaxy-bitwf/scripts/2790.diff' do
  source '2790.diff.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
  action :nothing
end
