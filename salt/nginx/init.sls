nginx:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/nginx/conf.d/custom.conf
      - file: {{ pillar['rhsite-ssl']['cert-path'] }}
      - file: {{ pillar['rhsite-ssl']['cert-key-path'] }}


/etc/nginx/conf.d/custom.conf:
  file.managed:
    - source: salt://nginx/custom-nginx.conf
    - template: jinja


{{ pillar['rhsite-ssl']['cert-path'] }}:
  file.managed:
    - makedirs: True
    - contents_pillar: rhsite-ssl:cert-contents

{{ salt['pillar.get']('rhsite-ssl:cert-key-path','/root/ssl/default') }}:
  file.managed:
    - makedirs: True
    - contents_pillar: rhsite-ssl:cert-key-contents


