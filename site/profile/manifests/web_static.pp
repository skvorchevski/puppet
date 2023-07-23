class profile::web_static {
  class { 'apache':
    file_name   => 'index.html',
    file_source => '/vagrant/index.html',
    is_dynamic  => false,
  }
}