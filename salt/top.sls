base:
  '*':
    - base_install.common_packages
    - base_install.ntp
    - rhnet.rhnet_site_setup
#  'roles:webserver'
#    - match: grain
#    - webserver.nginx
