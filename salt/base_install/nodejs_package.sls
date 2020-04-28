nodejs-repo:
  pkgrepo.managed:
    - humanname: NodeJS nodesource repo
    - name: deb https://deb.nodesource.com/node_14.x bionic main
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key

nodejs:
  pkg:
    - installed
    - require:
      - pkgrepo: nodejs-repo
