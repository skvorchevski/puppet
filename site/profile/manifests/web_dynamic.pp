class profile::web_dynamic {
  class { 'apache':
    file_name   => 'index.php',
    file_source => '/vagrant/index.php',
    is_dynamic  => true,
  }
}