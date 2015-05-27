#
# Cookbook Name:: basicsetup
# Recipe:: Rinstall
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
case node['platform']
when "centos"
  package "R"
when "ubuntu"
  apt_repository 'R' do
    uri        'http://cran.md.tsukuba.ac.jp//bin/linux/ubuntu'
    #deb http://jp.archive.ubuntu.com/ubuntu/ trusty main restricted
    #
    components ['trusty/']
    keyserver    'keyserver.ubuntu.com'
    key          'E084DAB9'
  end

  package "r-base"
end
