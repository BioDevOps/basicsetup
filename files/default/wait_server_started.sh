#!/bin/bash

expect -c "
set timeout -1
spawn tailf /usr/local/galaxy/galaxy-dist/paster.log
expect \"serving on http\"
"
echo "GALAXY STARTED"
