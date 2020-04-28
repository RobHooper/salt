# vim: set shiftwidth=2 tabstop=2 softtabstop=-1 expandtab:
base:
	'*':
		- base_install.common_packages
		- base_install.ntp
#		- base_install.admin_users
#	'web*':
#		- webserver.nginx
#		- webserver.php-fpm 
  'test_site':
		- rhnet_site_setup
		
