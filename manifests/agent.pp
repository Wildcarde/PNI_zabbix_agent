# Zabbix client - a host that needs the zabbix agent
# initially built from cse'ss code but adapted heavily to more recent puppet approaches.

class PNI_zabbix::agent {

  package { 'zabbix-agent' :
    ensure => present,
  }

  service { 'zabbix-agent' :
    ensure  => running,
    require => Package['zabbix-agent'],
    enable  => true,
  }

  augeas { 'zabbix_agentd.conf' :
    lens    => 'Simplevars.lns',
    incl    => '/etc/zabbix/zabbix_agentd.conf',
    notify  => Service['zabbix-agent'],
    require => Package['zabbix-agent'],
    changes => [
      'rm Hostname',
      "set Server ${server}",
      "set ServerActive ${server}",
      "set HostMetadata \"Kernel=${::kernel}\"",
      ],
  }

  # Individual config files to be installed

  # lint:ignore:autoloader_layout lint:ignore:nested_classes_or_defines For loop
  define zabbix_configs {
    # lint:endignore
    file { $name :
      path    => "/etc/zabbix/zabbix_agentd.d/${name}",
      mode    => '0640',
      owner   => 'root',
      group   => 'zabbix',
      source  => "puppet:///modules/cses/zabbix_agentd.d/${name}",
      notify  => Service['zabbix-agent'],
      require => Package['zabbix-agent'],
    }
  }

  cses::zabbix::client::zabbix_configs { ['partitions.conf', 'slurm.conf'] : }

  if hiera('cses::firewall::active') {
    firewall { '015 Allow connections for zabbix agent' :
      source => $server,
      dport  => 10050,
      action => accept,
      proto  => tcp,
      before => undef,
    }
  }

}
