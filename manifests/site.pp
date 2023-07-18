node slave1.puppet {
	package { 'httpd':
		ensure => installed,
	}

	file { '/tmp/index.html':
		ensure => present,
		source => "/var/www/html/index.html",
  }

	service { 'httpd':
		ensure => running,
		enable => true,
	}

	exec { 'open-port-8080':
		command => '/usr/bin/firewall-cmd --zone=public --add-port=8080/tcp --permanent',
		path    => '/usr/bin',
	}
}

node slave2.puppet {
	package { 'httpd':
		ensure => installed,
	}

	file { 'index.html':
		path => '/var/www/html/index.html',
		ensure => absent,
	}

	file { '/tmp/index.php':
		ensure => present,
		source => "/var/www/html/index.php",
	}

	service { 'httpd':
		ensure => running,
		enable => true,
	}

	exec { 'open-port-8080':
		command => '/usr/bin/firewall-cmd --zone=public --add-port=8080/tcp --permanent',
		path    => '/usr/bin',
	}
}