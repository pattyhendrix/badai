# AUTOGENERATED! DO NOT EDIT! File to edit: nbs/00_core.ipynb (unless otherwise specified).

__all__ = ['print_obj', 'bytes_encode', 'bytes_decode']

# Cell

from ppretty import ppretty

def print_obj(obj, depth=1, indent='  ', width=100, seq_length=1000,show_protected=False,
             show_private=True, show_static=True, show_properties=True, show_address=False, str_length=1000):
    "Print everything that belongs to an object"
    print(ppretty(obj, depth=depth,indent=indent,width=width,seq_length=seq_length,
                  show_protected=show_protected,show_private=show_private,show_static=show_static,
                  show_properties=show_properties,show_address=show_address, str_length=str_length))

# Cell

import base64

def bytes_encode(bites):
    "Encode bytes to base64 string"
    return base64.b64encode(bites).decode('utf-8')

def bytes_decode(encoded):
    "Decode base64 string to bytes"
    return base64.b64decode(encoded)