import re

def is_valid_IP(strng):
    return bool(re.fullmatch(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$',strng))