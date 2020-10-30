#!/bin/bash

FILE_VARIABLES="./variables.sh"
source ./variables.sh

OUTPUT="$MY_PATH/check_health.sh"
echo -e '#!/bin/bash\n' >"$OUTPUT"
chmod u+x "$OUTPUT"

# For bash 4.x, must not be in posix mode, may use temporary files
mapfile -t my_ips < <(grep -E "^declare -r IP_[[:alpha:]]+_HEALTH" $FILE_VARIABLES | awk -F " " '{print $3}' | tr -d '"') # array healths

function get_curl() {

    my_curl="#echo -e \"\${PURPLE_COLOUR}[-] check $zone\${RESET_COLOUR}\"
    req=\$(curl -s --connect-timeout 5 --header \"Content-Type: application/json\" \\
   --request POST \\
   --data '{\"token\":\"RG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ\"}' \\
   http://$1:8888/health)
if [[ \"\$req\" == \"\" ]]; then
    echo -e \"\${RED_COLOUR}[-] $2: timeout\${RESET_COLOUR}\" \\n
else
    if [[ \"\$(echo \$req | jq '.status' | tr -d '\"')\" == \"ok\" ]]; then
        echo -e \"\${GREEN_COLOUR}[+] $2: \$(echo \$req | jq '.status' | tr -d '\"')\${RESET_COLOUR}\" \\n
    else
        echo -e \"\${RED_COLOUR}[-] $2: \$(echo \$req | jq '.status' | tr -d '\"')\${RESET_COLOUR}\" \\n
    fi
fi\n"
    echo "$my_curl"
}

function write_file() {
    echo -e "$1" >>"$OUTPUT"
}

function foreach_ips() {
    write_file "clear\n"
    write_file "source ./variables.sh\n"

    write_file "echo -e \"\${BLUE_COLOUR}[*] run checks:\${RESET_COLOUR}\" \n"

    for ip in "${my_ips[@]}"; do
        name=$(echo "$ip" | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
        zone=$(echo "$ip" | awk -F "=" '{print $1}' | awk -F "_" '{print $2}')
        addr=$(echo "$ip" | awk -F "=" '{print $2}')

        ncurl=$(get_curl "$addr" "$zone")
        write_file "$ncurl"
    done
}

foreach_ips
