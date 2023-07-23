class nginx (
  String $nginx_conf_source,
) {
  package { 'nginx':
    ensure => installed,
  }

  exec { 'open-port-8080':
    command => '/usr/bin/firewall-cmd --add-port=8080/tcp --permanent',
    path    => '/usr/bin',
  }

  exec { 'open-port-8081':
    command => '/usr/bin/firewall-cmd --add-port=8081/tcp --permanent',
    path    => '/usr/bin',
  }

  exec { 'restart_firewalld':
    command => '/usr/bin/systemctl restart firewalld',
    path    => '/usr/bin:/bin',
  }

  -> file { '/etc/nginx':
    ensure => directory,
    source => $nginx_conf_source,
  }

  ~> service { 'nginx':
    ensure => running,
    enable => true,
  }
}