base:
  '*':
    - base_install.common_packages
    - base_install.ntp
  'roles:rhnet':
    - match: grain
    - rhnet.rhnet_site_setup
    - rhnet.supervisor
  'roles:webserver':
    - match: grain
    - nginx
