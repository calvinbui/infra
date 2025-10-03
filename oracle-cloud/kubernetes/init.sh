#!/bin/bash

if [ -f /usr/libexec/oci-growfs ]; then 
  /usr/libexec/oci-growfs -y 
fi

oke_init_script=$(curl --fail -m 5 -H "Authorization: Bearer Oracle" -L0 http://169.254.169.254/opc/v2/instance/metadata/oke_init_script)
if [ $? -ne 0 ]; then
  oke_init_script=$(curl --fail -m 5 -g -H "Authorization: Bearer Oracle" -L0 http://[fd00:c1::a9fe:a9fe]/opc/v2/instance/metadata/oke_init_script)
fi
echo $oke_init_script | base64 --decode > /var/run/oke-init.sh
touch /var/run/.oke-default-cloud-init

bash /var/run/oke-init.sh