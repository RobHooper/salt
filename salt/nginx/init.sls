nginx:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/nginx/conf.d/custom.conf


/etc/nginx/conf.d/custom.conf:
  file.managed:
    - source: salt://nginx/custom-nginx.conf
