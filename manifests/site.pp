node slave1.puppet {
  include role::slave1_machine
}

node slave2.puppet {
  include role::slave2_machine
}

node mineserver.puppet {
  package { 'openjdk-17-jdk':
  ensure => installed,
  }

  include minecraft
}

node master.puppet {
  include role::master_machine
}