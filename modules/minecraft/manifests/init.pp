class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
    before => File['minecraft_file']
  }

  file { 'minecraft_server.1.20.1.jar':
    path    => "/opt/minecraft",
    source  => "https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar",
    mode    => "755",
    require => File['/opt/minecraft'],
  }

  file { 'minecraft_service':
    path   => "/etc/systemd/system/minecraft.service",
    source => "puppet:///modules/minecraft/minecraft.service",
    notify => Service['minecraft'],
  }

  service { 'minecraft':
    ensure  => running,
    require => File['minecraft_service'],
  }
}