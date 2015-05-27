#
# Cookbook Name:: basicsetup
# Recipe:: default
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
case node['platform']
when "centos"
  include_recipe "yum-epel"
when "ubuntu"
  #include_recipe "ubuntu-change-source-list"
  #include_recipe "apt"
  #execute 'foo' do
  #  command 'apt-get update'
  #end
end
# java
include_recipe "java"

# build-essential
include_recipe "build-essential"
# build related package
case node['platform']
when "ubuntu"
  ### packages for ubuntu
  %w{
make
libssl-dev
zlib1g-dev
libbz2-dev
libreadline-dev
libsqlite3-dev
libxml2
libxml2-dev
libxslt1.1
libxslt1-dev
wget
curl
llvm
nkf
  }.each do |p|
    package p do
      action :install
    end
  end

when "centos"
  ### packages for centos
  %w{
zlib-devel
bzip2
bzip2-devel
readline-devel
sqlite
sqlite-devel
openssl-devel
libxml2
libxml2-devel
libxslt
libxslt-devel
nkf
  }.each do |p|
    package p do
      action :install
    end
  end

end
# build related package
case node['platform']
when "ubuntu"
  ### packages for ubuntu
  %w{
make
libssl-dev
zlib1g-dev
libbz2-dev
libreadline-dev
libsqlite3-dev
libxml2
libxml2-dev
libxslt1.1
libxslt1-dev
wget
curl
llvm
nkf
git
  }.each do |p|
    package p do
      action :install
    end
  end

when "centos"
  ### packages for centos
  %w{
zlib-devel
bzip2
bzip2-devel
readline-devel
sqlite
sqlite-devel
openssl-devel
libxml2
libxml2-devel
libxslt
libxslt-devel
nkf
git
  }.each do |p|
    package p do
      action :install
    end
  end

end
### mount
case node['platform']
when "centos"
  %w{
nfs-utils
rpcbind
}.each do |p|
    package p do
      action :install
    end
  end
when "ubuntu"
  %w{
nfs-common
}.each do |p|
    package p do
      action :install
    end
  end
end
