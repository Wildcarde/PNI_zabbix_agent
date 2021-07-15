class pnizabbix::agent::service{

  include pnizabbix::params

  service { 'zabbix-agent' :
    ensure  => running,
    require => Package['zabbix-agent'],
    enable  => true,
  }
}
