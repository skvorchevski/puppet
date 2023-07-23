class profile::profile_nginx (
  String $conf_source = 'puppet:///files/nginx.conf',
) {
  class { 'nginx':
    nginx_conf_source => $conf_source
  }
}