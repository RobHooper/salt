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

rkhunter_extract:
  archive.extracted:
    - name: /tmp/
    - source: /tmp/rkhunter-{{ rkhunter_version }}.tar.gz
    - tar_options: xz
    - archive_format: tar

rkhunter_install:
  cmd.run:
    - cwd: /tmp/rkhunter-{{ rkhunter_version }}
    - name: ./installer.sh --layout /usr/local --install
    - creates: /usr/local/bin/rkhunter 
  require:
    - salt: rkhunter_extract

## Clean up
/tmp/rkhunter-{{ rkhunter_version }}.tar.gz:
  file.absent

/tmp/rkhunter-{{ rkhunter_version }}:
  file.absent

rkhunter_update:
  cmd.wait:
    - name: /usr/local/bin/rkhunter --update
  watch:
    - file: /usr/local/bin/rkhunter

/usr/local/bin/rkhunter --propupd:
  cmd.run
#  cmd.wait:
#    - watch:
#      - file: /usr/local/bin/rkhunter

/etc/rkhunter.conf.local:
  file.managed: 
    - source: salt://sysadmin-tools/rkhunter.conf.local

# link cron
# Eh later, it's the same process as above
