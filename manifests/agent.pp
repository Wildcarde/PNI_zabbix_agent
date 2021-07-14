# Zabbix client - a host that needs the zabbix agent
# initially built from cse'ss code but adapted heavily to more recent puppet approaches.

class pnizabbix::agent{

  include PNIzabbix::params

  class {'pnizabbix::agent::install':}
  class {'pnizabbix::agent::config':}
  class {'pnizabbix::agent::service':}

  # if hiera('cses::firewall::active') {
  #   firewall { '015 Allow connections for zabbix agent' :
  #     source => $server,
  #     dport  => 10050,
  #     action => accept,
  #     proto  => tcp,
  #     before => undef,
  #   }
  # }

}
