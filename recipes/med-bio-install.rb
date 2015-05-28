#
# Cookbook Name:: basicsetup
# Recipe:: me-bio-install
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
case node['platform']
when "ubuntu"
  execute "ufw" do
    command <<-EOF
DEBIAN_FRONTEND=noninteractive apt-get -y install med-bio
  EOF
  end
end
