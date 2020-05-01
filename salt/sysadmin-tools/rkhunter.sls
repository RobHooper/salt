# Install and configure RKHunter 

{% set rkhunter_version = '1.4.6' %}

{% set rkhunter_download_url = ''.join(["http://downloads.sourceforge.net/project/rkhunter/rkhunter/",rkhunter_version,"/rkhunter-",rkhunter_version,".tar.gz"]) %}

rkhunter_requirements:
  pkg.installed: 
    - pkgs:
      - wget
      - binutils

rkhunter_download:
  cmd.run:
    - cwd: /tmp
    - name: wget {{ rkhunter_download_url }}
    # This stops it from running twice if it's already installed
    - creates: /usr/local/bin/rkhunter

## Could wrap in jinja but it doesn't seem to test properly each time I run the file
#{%- if salt['file.file_exists' ]('/tmp/rkhunter-{{ rkhunter_version }}.tar.gz') %}
#{%- endif %}
## Other solutions 
# https://serverfault.com/questions/883742/saltstack-do-x-if-var-log-backup-exists

rkhunter_install:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/rkhunter-{{ rkhunter_version }}.tar.gz
    - tar_options: xz
    - archive_format: tar
    - onlyif:
      - test -f /tmp/rkhunter-{{ rkhunter_version }}.tar.gz
  file.directory:
    # cwd in cmd.run is done before testing onlyif :/ 
    - name: /tmp/rkhunter-{{ rkhunter_version }}
  cmd.run:
    - cwd: /tmp/rkhunter-{{ rkhunter_version }}
    - name: ./installer.sh --layout /usr/local --install
    - onlyif:
      - test -f /tmp/rkhunter-{{ rkhunter_version }}.tar.gz

rkhunter_update:
  cmd.run:
    - name: /usr/local/bin/rkhunter --update
    - onlyif:
      - test -f /tmp/rkhunter-{{ rkhunter_version }}.tar.gz

rkhunter_propupd:
  cmd.run:
    - name: /usr/local/bin/rkhunter --propupd
    - onlyif:
      - test -f /tmp/rkhunter-{{ rkhunter_version }}.tar.gz

/etc/rkhunter.conf.local:
  file.managed: 
    - source: salt://sysadmin-tools/rkhunter.conf.local

# link cron
# Eh later, it's the same process as above
#
## Clean up
/tmp/rkhunter-{{ rkhunter_version }}.tar.gz:
  file.absent

# Rather than removing the directory, I'm only removing the contents.
# This is related to the rkhunter onlyif cwd issue above
/tmp/rkhunter-{{ rkhunter_version }}:
  file.directory:
    - clean: True

