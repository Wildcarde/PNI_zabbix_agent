class pnizabbix::agent::service{

  service { 'zabbix-agent' :
    ensure  => running,
    require => Package['zabbix-agent'],
    enable  => true,
  }
}
