class profile::profile_nginx {
  class { 'nginx':
    manage_repo    => true,
    service_manage => true,
    service_ensure => 'running',
    service_enable => true,
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

  -> file { '/etc/nginx/conf.d/nginx.conf':
    source => '/vagrant/nginx.conf',
    ensure => present,
  }

  ~> exec { 'nginx-restart':
    command     => '/usr/sbin/service nginx restart',
    refreshonly => true,
  }
}