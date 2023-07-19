node slave1.puppet {
	package { 'httpd':
		ensure => installed,
	}

	file { '/var/www/html/index.html':
		ensure => present,
		source => "/vagrant/index.html",
	}

	exec { 'open-port-80':
		command => '/usr/bin/firewall-cmd --add-port=80/tcp --permanent',
		path    => '/usr/bin',
	}

	exec { 'restart_firewalld':
		command => 'systemctl restart firewalld',
		path    => '/usr/bin:/bin',
	}
}

node slave2.puppet {
	package { 'httpd':
		ensure => installed,
	}

	package { 'php':
		ensure => installed,
	}

	file { '/var/www/html/index.php':
		ensure => present,
		source => '/vagrant/index.php',
	}

	file { '/var/www/html/index.html':
		ensure => absent,
	}

	exec { 'open-port-80':
		command => '/usr/bin/firewall-cmd --add-port=80/tcp --permanent',
		path    => '/usr/bin',
	}

	exec { 'open-port-80':
		command => '/usr/bin/firewall-cmd --add-port=80/tcp --permanent',
		path    => '/usr/bin',
	}

	exec { 'restart_firewalld':
		command => 'systemctl restart firewalld',
		path    => '/usr/bin:/bin',
	}
}