include:
  - base_install.nodejs_package

rh-user:
  user.present:
    - name: rh-user
    - home: /home/rh-user
#  - shell: /bin/bash
#  - password: 

rh-site-source:
  git.latest:
    - name: https://github.com/bobalob3/robhooper.net.git
    - rev: master
    - target: /home/rh-user/public_html
    - require:
      - user: rh-user
      - pkg: common_packages
      - sls: base_install.nodejs_package

rh-npm-install:
  cmd.wait:
    - name: npm install
    - cwd: /home/rh-user/public_html
    - watch:
       - git: rh-site-source

#rh-site-build:
#  cmd.wait:
#    - name: npm run-script build
#    - cwd: /home/rh-user/public_html
#    - watch:
#      - cmd: rh-npm-install
