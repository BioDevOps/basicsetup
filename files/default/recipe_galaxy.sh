#!/bin/bash
cd /usr/local/galaxy

# s5

mkdir work
cd work
git clone https://github.com/myoshimura080822/galaxy_in_docker_custom.git
cd galaxy_in_docker_custom/

#mkdir /galaxy
cp ./install_rnaseqENV.R /galaxy/install_rnaseqENV.R
#chown galaxy:galaxy -R /galaxy

# s7
cd /usr/local/galaxy/galaxy-dist
wget https://raw.githubusercontent.com/bgruening/docker-galaxy-stable/18ed1a390595b1efeb671e21f9b2f0604a0483ae/galaxy/create_galaxy_user.py
python ./create_galaxy_user.py --user admin@galaxy.org --password admin --key admin
#install-repository "--url https://toolshed.g2.bx.psu.edu/ -o devteam --name tophat2 -r da1f39fe14bc --panel-section-name NGS-tools" \
../local-install-repository.sh "--url https://toolshed.g2.bx.psu.edu/ -o devteam --name tophat2 -r da1f39fe14bc --panel-section-name NGS-tools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o devteam --name express -r 7b0708761d05 --panel-section-name NGS-tools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o fcaramia --name edger -r 6324eefd9e91 --panel-section-name NGS-tools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o devteam --name bowtie2 -r c1ec08cb34f9 --panel-section-name NGS-tools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o jjohnson --name fastq_mcf -r b61f1466ce8f --panel-section-name NGS-QCtools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o devteam --name fastqc -r 0b201de108b9 --panel-section-name NGS-QCtools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o fubar --name toolfactory --panel-section-name Create-tools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o fubar --name tool_factory_2 --panel-section-name Create-tools" \
    "--url https://toolshed.g2.bx.psu.edu/ -o devteam --name samtools_flagstat -r 0072bf593791 --panel-section-name NGS-QCtools"

# s8
cd /galaxy
git clone https://github.com/myoshimura080822/galaxy-mytools_ToolFactory.git
mv /shed_tools/toolshed.g2.bx.psu.edu/repos/fubar/toolfactory/e9ebb410930d/toolfactory/rgToolFactory.py /shed_tools/toolshed.g2.bx.psu.edu/repos/fubar/toolfactory/e9ebb410930d/toolfactory/rgToolFactory_BK.py
cp /galaxy/galaxy-mytools_ToolFactory/rgToolFactory.py /shed_tools/toolshed.g2.bx.psu.edu/repos/fubar/toolfactory/e9ebb410930d/toolfactory/
mv /shed_tools/toolshed.g2.bx.psu.edu/repos/fubar/toolfactory/e9ebb410930d/toolfactory/rgToolFactory.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/fubar/toolfactory/e9ebb410930d/toolfactory/rgToolFactory_BK.xml
cp /galaxy/galaxy-mytools_ToolFactory/rgToolFactory.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/fubar/toolfactory/e9ebb410930d/toolfactory/

# s9
cd /usr/local/galaxy/work/
git clone https://github.com/myoshimura080822/galaxy_in_docker_custom_bit_wf.git
cd galaxy_in_docker_custom_bit_wf/
# 以下の２つは、VMを作るときは、chefでの設定を上書きしてしまうのでいらない
#cp ./galaxy.ini.docker_sample /galaxy-central/config/galaxy.ini
#cp ./job_conf.xml.docker_sample /galaxy-central/config/job_conf.xml
cp ./datatypes_conf.xml.docker_sample /galaxy-central/config/datatypes_conf.xml
#mv /galaxy-central/lib/galaxy/datatypes/data.py /galaxy-central/lib/galaxy/datatypes/data.py_bk
#mv /galaxy-central/lib/galaxy/datatypes/sniff.py /galaxy-central/lib/galaxy/datatypes/sniff.py_bk
#mv /galaxy-central/tools/data_source/upload.py /galaxy-central/tools/data_source/upload.py_bk
# /galaxy related
cp setup_scripts/bit-tools_install_docker.py /galaxy/bit-tools_install_docker.py
python /galaxy/bit-tools_install_docker.py
cp -a /galaxy-central/config/tool_conf.xml.main /galaxy-central/config/tool_conf.xml



#
cp modefied_tools/for_latest_fastq-mcf.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/jjohnson/fastq_mcf/b61f1466ce8f/fastq_mcf/fastq-mcf.xml
cp modefied_tools/edger_robust/edgeR.pl /shed_tools/toolshed.g2.bx.psu.edu/repos/fcaramia/edger/6324eefd9e91/edger/edgeR.pl
cp modefied_tools/edger_robust/edgeR.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/fcaramia/edger/6324eefd9e91/edger/edgeR.xml
#
#cp modefied_tools/for_latest_rgFastQC.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/fastqc/8c650f7f76e9/fastqc/rgFastQC.xml
cp modefied_tools/for_latest_rgFastQC.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/fastqc/2d094334f61e/fastqc/rgFastQC.xml

# Setting Sailfish and Bowtie2 or Tophat Index
cp setup_scripts/setting_tools_index.py /galaxy/setting_tools_index.py
cp setup_scripts/index_file_list.txt /galaxy/index_file_list.txt
cp setup_scripts/index_file_list_tophat.txt /galaxy/index_file_list_tophat.txt

cd /galaxy
cp -a /galaxy-central/config/tool_data_table_conf.xml.sample /galaxy-central/config/tool_data_table_conf.xml
python /galaxy/setting_tools_index.py index_file_list.txt F
python /galaxy/setting_tools_index.py index_file_list_tophat.txt T

# s10
# Install Sailfish
cd /galaxy
wget https://github.com/kingsfordgroup/sailfish/releases/download/v0.6.3/Sailfish-0.6.3-Linux_x86-64.tar.gz
tar -zxvf Sailfish-0.6.3-Linux_x86-64.tar.gz
rm Sailfish-0.6.3-Linux_x86-64.tar.gz
mv /galaxy/Sailfish-0.6.3-Linux_x86-64/lib/libz.so.1 /galaxy/Sailfish-0.6.3-Linux_x86-64/lib/libz.so.1_bk


