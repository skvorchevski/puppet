class apache (
  String $file_name,
  String $file_source,
  Boolean $is_dynamic,
) {

  package { 'httpd':
    ensure => installed,
  }

  if $is_dynamic {
    package { 'php':
      ensure => installed,
    }

    file { '/var/www/html/index.html':
      ensure => absent,
    }
  }

  file { "/var/www/html/$file_name":
    ensure => present,
    source => $file_source,
  }

  exec { 'open-port-80':
    command => '/usr/bin/firewall-cmd --add-port=80/tcp --permanent',
    path    => '/usr/bin',
  }

  exec { 'restart_firewalld':
    command => '/usr/bin/systemctl restart firewalld',
    path    => '/usr/bin:/bin',
  }

  service { 'httpd':
    ensure  => running,
    enable  => true,
    require => Package['httpd'],
  }
}