class pnizabbix::agent::config{


  file {'zabbix_agent_config':
    path => '/etc/zabbix/zabbix_agentd.conf'
    content => template('pnizabbix/zabbix_agentd.conf.5.2.ebb'),
  }

##old code from cses
  #   augeas { 'zabbix_agentd.conf' :
  #   lens    => 'Simplevars.lns',
  #   incl    => '/etc/zabbix/zabbix_agentd.conf',
  #   notify  => Service['zabbix-agent'],
  #   require => Package['zabbix-agent'],
  #   changes => [
  #     'rm Hostname',
  #     "set Server ${server}",
  #     "set ServerActive ${server}",
  #     "set HostMetadata \"Kernel=${::kernel}\"",
  #     ],
  # }

  # # Individual config files to be installed

  # # lint:ignore:autoloader_layout lint:ignore:nested_classes_or_defines For loop
  # define zabbix_configs {
  #   # lint:endignore
  #   file { $name :
  #     path    => "/etc/zabbix/zabbix_agentd.d/${name}",
  #     mode    => '0640',
  #     owner   => 'root',
  #     group   => 'zabbix',
  #     source  => "puppet:///modules/cses/zabbix_agentd.d/${name}",
  #     notify  => Service['zabbix-agent'],
  #     require => Package['zabbix-agent'],
  #   }
  # }

  # cses::zabbix::client::zabbix_configs { ['partitions.conf', 'slurm.conf'] : }

}
