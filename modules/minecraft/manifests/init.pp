class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
  }

  file { 'server.jar':
    path   => '/opt/minecraft/',
    ensure => present,
    source => "https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar",
    mode   => "755",
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