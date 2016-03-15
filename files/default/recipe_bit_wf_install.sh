cd /usr/local/galaxy/work/galaxy_in_docker_custom_bit_wf/setup_scripts
source /usr/local/galaxy/galaxy-dist/.venv/bin/activate; pip install python-dateutil==2.5.0 bioblend==0.7.0 pandas==0.17.1 grequests==0.3.0 GitPython==1.0.2 pip-tools==1.6
python bit-workflow_install_docker.py

