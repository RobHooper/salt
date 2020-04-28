# vim: set shiftwidth=2 tabstop=2 softtabstop=-1 expandtab:

rh-site-requirements:
	pkg.installed:
      - npm



rh-user:
	user.present:
		- name: rh-user
		- home: /home/rh-user
#		- shell: /bin/bash
#		- password: 

#rh-site-source:
#	git.latest:
#		- name: https://github.com/bobalob3/robhooper-site.git
#		- rev: master
#		- target: /home/rh-user/public_html


#rh-site-install:
#	cmd.wait:
#		- name: npm install
#		- cwd: /home/rh-user/public_html
#    - watch:
#      - git: rh-site-source
#
#rh-site-build:
#	cmd.wait:
#		- name: npm run-script build
#		- cwd: /home/rh-user/public_html
#    - watch:
#      - git: rh-site-install
