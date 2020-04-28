# vim: set shiftwidth=2 tabstop=2 softtabstop=-1 expandtab:

systemd-timezoned:
  service.stop: []

ntp:
  pkg:
    - installed
  service:
    - running
