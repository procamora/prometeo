#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Need parametres with name client"
    exit 1
fi


# First argument: Client identifier

KEY_DIR={{ path_ssl }}
KEY_DIR_CLIENTS={{ path_clients_ssl }}
OUTPUT_DIR={{ path_clients }}/files
BASE_CONFIG={{ path_clients }}/clients.conf

cd {{ path_easy_rsa }}
bash easyrsa --batch gen-req $1 nopass
bash easyrsa --batch sign-req client $1
cp pki/private/$1.key {{ path_clients_ssl }}
cp pki/issued/$1.crt {{ path_clients_ssl }}
cd - >/dev/null


cat ${BASE_CONFIG} \
<(echo -e '<ca>') \
${KEY_DIR}/ca.crt \
<(echo -e '</ca>\n<cert>') \
${KEY_DIR_CLIENTS}/${1}.crt \
<(echo -e '</cert>\n<key>') \
${KEY_DIR_CLIENTS}/${1}.key \
<(echo -e '</key>\n<tls-crypt>') \
${KEY_DIR}/ta.key \
<(echo -e '</tls-crypt>') \
> ${OUTPUT_DIR}/${1}.ovpn
