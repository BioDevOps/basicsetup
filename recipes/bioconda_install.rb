#
# Cookbook Name:: basicsetup
# Recipe:: bioconda_install
#
# Copyright (c) [2015] [Manabu ISHII] and RIKEN Bioinformatics Research Unit
# Released under the [Apache2 license]
#
# Instaruction is here
# https://bioconda.github.io/
#
bash "install-conda-conda-forge" do
  code   "source /etc/profile.d/anaconda-env.sh; conda config --add channels conda-forge --system"
  action :run
  notifies :run, "bash[install-conda-defaults]"
end
bash "install-conda-defaults" do
  code   "source /etc/profile.d/anaconda-env.sh; conda config --add channels defaults --system"
  action :nothing
  notifies :run, "bash[install-conda-r]"
end
bash "install-conda-r" do
  code   "source /etc/profile.d/anaconda-env.sh; conda config --add channels r --system"
  action :nothing
  notifies :run, "bash[install-conda-bioconda]"
end
bash "install-conda-bioconda" do
  code   "source /etc/profile.d/anaconda-env.sh; conda config --add channels bioconda --system"
  action :nothing
end
