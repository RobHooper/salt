base:
  '*':
    - common
    - local-ip-mine
  'roles:webserver':
    - match: grain
    - override
  'roles:rhnet':
    - match: grain
    - rhnet.rh-ssl
