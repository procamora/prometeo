#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import time
import sys
import os
from pathlib import Path
import re
from typing import Text, List, Tuple

f2: Path = Path('./variables.sh')
var = f2.read_text()


def get_value_var(key: Text) -> Text:
    regex = rf'declare -r {key}="(.*)"'
    response = re.search(regex, var)
    if response:
        return response.group(1)
    else:
        print("fuck")
        return ""


def mfilter(key: Text, values: Text) -> [Text, Text]:
    # print(key)
    # print(values)
    if re.search('COLOUR', key, re.IGNORECASE):
        return ['', '']

    if key == 'KEY':
        values = str(Path(Path(__file__).resolve().parent.parent, 'certificates', 'openssh', 'id_rsa'))
    elif re.search(r'\$key', values, re.IGNORECASE):
        nkey: Text = str(Path(Path(__file__).resolve().parent.parent, 'certificates', 'openssh', 'id_rsa'))
        values = re.sub(r'\$key', nkey, values, flags=re.IGNORECASE)

    if re.search(r'\$', key) or re.search(r'\$', values):
        print(F"POSIBLE PROBLEMA CON: {key} -> {values}")

    return [key, values]


def get_keys_var() -> List[Tuple]:
    """
    Obtiene una lista con todas las KEYs que hay en el fichero de variables.sh
    :return:
    """
    response: List[Tuple] = list(tuple())
    for i in var.splitlines():
        resp = re.search(r'^declare -r (\w+)="(.*)".*$', i)
        if len(i) > 0 and resp:
            key, values = mfilter(str(resp.group(1)), str(resp.group(2)))
            response.append((key, values))
    return response


def generate_tfvars(list_var: List[Tuple]):
    output: Text = "# DON'T EDIT, auto-generated file\n\n"
    for i in list_var:
        if len(i[0]) > 0:
            output += f'{i[0].lower()} = "{i[1].lower()}"\n'

    # print(output)
    Path('./prometeo.tfvars').write_text(output)


def main():
    list_var: List[Tuple] = get_keys_var()

    generate_tfvars(list_var)


if __name__ == '__main__':
    main()
