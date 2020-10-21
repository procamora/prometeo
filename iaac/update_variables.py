#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from pathlib import Path
import re
from typing import Text, List, Tuple


def mfilter(key: Text, values: Text) -> [Text, Text]:
    """
    modifica y/o elimina las key/value segun los criterios indicados
    :param key:
    :param values:
    :return:
    """
    # print(key)
    # print(values)
    if re.search('COLOUR', key, re.IGNORECASE):
        return ['', '']

    # eliminar variable key y poner valor real
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
    f2: Path = Path('./variables.sh')
    var = f2.read_text()

    for i in var.splitlines():
        resp = re.search(r'^declare -r (\w+)="(.*)".*$', i)
        if len(i) > 0 and resp:
            key, values = mfilter(str(resp.group(1)), str(resp.group(2)))
            response.append((key, values))
    return response


def generate_tfvars(list_var: List[Tuple]):
    output_tfvars: Text = "# DON'T EDIT, auto-generated file\n\n"
    output_vars: Text = "# DON'T EDIT, auto-generated file\n\n"

    for i in list_var:
        if len(i[0]) > 0:
            output_tfvars += f'{i[0].lower()} = "{i[1].lower()}"\n'
            output_vars += f'''
variable "{i[0].lower()}" {{
  type = string
  description = "value set '{i[1].lower()}' in terraform.tfvars"
  # default = "{i[1].lower()}"
}}\n'''

    # print(output)
    Path('./terraform.tfvars').write_text(output_tfvars)
    Path('./variables.tf').write_text(output_vars)


def main():
    list_var: List[Tuple] = get_keys_var()

    generate_tfvars(list_var)


if __name__ == '__main__':
    main()
