class pnizabbix::agent::install{

  include pnizabbix::params

  package { 'zabbix52-agent2' :
    ensure => latest,
  }

}
