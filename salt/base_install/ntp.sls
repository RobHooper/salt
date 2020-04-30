# vim: set shiftwidth=2 tabstop=2 softtabstop=-1 expandtab:

systemd-timesyncd:
  service.dead:
    - enable: False

ntp:
  pkg:
    - installed
  service:
    - running
