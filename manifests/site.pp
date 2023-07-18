node slave1.puppet {
	package { 'httpd':
		ensure => installed,
	}

	file { '/tmp/index.html':
		ensure => present,
		source => "/var/www/html/index.html",
  }

	exec { 'open-port-80':
		command => '/usr/bin/firewall-cmd --add-port=80/tcp --permanent',
		path    => '/usr/bin',
	}

	service { 'httpd':
		ensure => running,
		enable => true,
	}
}

node slave2.puppet {
	package { 'httpd':
		ensure => installed,
	}

	package { 'php':
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

	exec { 'open-port-80':
		command => '/usr/bin/firewall-cmd --add-port=80/tcp --permanent',
		path    => '/usr/bin',
	}

	file { '/etc/httpd/conf/httpd.conf':
		ensure => present,
		content => "Listen 80\nServerName localhost\nDocumentRoot /var/www/html\nDirectoryIndex index.php\n",
		require => Package['httpd'],
		notify => Service['httpd'],
	}

	service { 'httpd':
		ensure => running,
		enable => true,
		require => File['/etc/httpd/conf/httpd.conf'],
	}
}