node slave1.puppet {
	package { 'httpd':
		ensure => installed,
	}

	file { '/tmp/index.html':
		ensure => present,
		source => "/var/www/html/",
    }

	service { 'httpd':
		ensure => running,
		enable => true,
	}

	firewalld_port { 'Open port 8080 in the public zone':
		ensure   => present,
		zone     => public,
		port     => 8080,
		protocol => 'tcp',
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
		source => "/var/www/html/",
	}

	service { 'httpd':
		ensure => running,
		enable => true,
	}

	firewalld_port { 'Open port 8080 in the public zone':
		ensure   => present,
		zone     => public,
		port     => 8080,
		protocol => 'tcp',
	}
}