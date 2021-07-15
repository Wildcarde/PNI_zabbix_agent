##this is just a small class specifically for managing the 

class pnizabbix::agent::service{

  include pnizabbix::params

  service { 'zabbix-agent2' :
    ensure  => running,
    require => Package['zabbix52-agent2'],
    enable  => true,
  }
}
