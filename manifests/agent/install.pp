class pnizabbix::agent::install{

  package { 'zabbix52-agent' :
    ensure => latest,
  }

}
