#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import sys
import os

import paramiko


# system package enable ipv6


def main():
    host = sys.argv[1]
    file = 'mk_config.auto.rsc'


    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        client.connect(host, 22, 'admin', '', allow_agent=False, look_for_keys=False, auth_timeout=2)
    except paramiko.AuthenticationException:
        client.close()
        raise 'paramiko.AuthenticationException'

    stdin, stdout, stderr = client.exec_command('system package enable ipv6')
    stdin, stdout, stderr = client.exec_command(':execute {/system reboot;}')
    time.sleep(10)
    os.system(f'curl -T {file} ftp://{host} --user admin:')
    stdin, stdout, stderr = client.exec_command(':execute {/system reboot;}')
    stdin, stdout, stderr = client.exec_command(f'import {file}')
    client.close()





if __name__ == '__main__':
    main()