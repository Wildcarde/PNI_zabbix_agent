class pnizabbix::agent::install{

  package { 'zabbix-agent' :
    ensure => present,
  }

}
