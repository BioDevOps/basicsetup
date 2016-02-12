name             'basicsetup'
maintainer       'RIKEN Bioinformatics Research Unit Released'
maintainer_email 'Manabu ISHII'
license          'Apache 2.0'
description      'Installs/Configures basicsetup for bioinformatics'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0-alpha'

depends 'build-essential', '= 2.1.3'
depends 'java', '= 1.31.0'
depends 'yum-epel', '= 0.6.0'
depends 'git', '= 4.1.0'
depends 'sudo', '= 2.7.1'
depends 'apt', '= 2.6.1'
