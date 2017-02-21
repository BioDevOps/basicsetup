#!/bin/bash

expect -c "
set timeout -1
spawn docker logs -f  galaxy_bitwf_1.3.0
expect \"Binding and starting galaxy\"
"
echo "GALAXY STARTED"
