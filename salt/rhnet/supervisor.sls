include:
  - rhnet.rhnet_site_setup

supervisor:
  pkg.installed:
    - require:
      - sls: rhnet.rhnet_site_setup
  service.running:
    - watch:
      - file: /etc/supervisor/conf.d/rh-site.conf


/etc/supervisor/conf.d/rh-site.conf:
  file.managed:
    - source: salt://rhnet/custom-supervisor.conf
    - require:
      - pkg: supervisor



