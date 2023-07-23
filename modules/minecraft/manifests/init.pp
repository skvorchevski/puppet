class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
  }

  exec { 'minecraft_server':
    command => 'curl -o /opt/minecraft/minecraft_server.jar https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar',
    creates => '/opt/minecraft/server.jar',
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