# class: zabbix::params
#
# this class manages zabbix server parameters
#
# parameters:
#
# actions:
#
# requires:
#
# sample usage:
#
class zabbix::params {
  # It seems that ubuntu has an different fping path...
  case $facts['os']['name'] {
    'Ubuntu', 'Debian' : {
      $server_fpinglocation     = '/usr/bin/fping'
      $server_fping6location    = '/usr/bin/fping6'
      $proxy_fpinglocation      = '/usr/bin/fping'
      $proxy_fping6location     = '/usr/bin/fping6'
      $manage_repo              = true
      $manage_choco             = false
      $zabbix_package_agent     = 'zabbix-agent'
      $agent_configfile_path    = '/etc/zabbix/zabbix_agentd.conf'
      $agent_config_owner       = 'zabbix'
      $agent_zabbix_user        = 'zabbix'
      $agent_config_group       = 'zabbix'
      $agent_pidfile            = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_servicename        = 'zabbix-agent'
      $agent_include            = '/etc/zabbix/zabbix_agentd.d'
      $server_zabbix_user       = 'zabbix'
      $zabbix_package_provider  = undef
      $agent_loadmodulepath     = '/usr/lib/modules'
    }
    'AIX': {
      $manage_repo              = false
      $zabbix_package_provider  = 'yum'
      $zabbix_package_agent     = 'zabbix-agent'
      $agent_configfile_path    = '/etc/zabbix/zabbix_agentd.conf'
      $agent_config_owner       = 'zabbix'
      $agent_zabbix_user        = 'zabbix'
      $agent_config_group       = 'zabbix'
      $agent_pidfile            = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_servicename        = 'zabbix-agent'
    }

    'Archlinux': {
      $server_fpinglocation     = '/usr/bin/fping'
      $server_fping6location    = '/usr/bin/fping6'
      $proxy_fpinglocation      = '/usr/bin/fping'
      $proxy_fping6location     = '/usr/bin/fping6'
      $manage_repo              = false
      $manage_choco             = false
      $zabbix_package_agent     = 'zabbix-agent'
      $agent_configfile_path    = '/etc/zabbix/zabbix_agentd.conf'
      $agent_config_owner       = 'zabbix-agent'
      $agent_zabbix_user        = 'zabbix-agent'
      $agent_config_group       = 'zabbix-agent'
      $agent_pidfile            = undef
      $agent_servicename        = 'zabbix-agent'
      $agent_include            = '/etc/zabbix/zabbix_agentd.d'
      $server_zabbix_user       = 'zabbix-server'
      $zabbix_package_provider  = undef
      $agent_loadmodulepath     = '/usr/lib/modules'
    }
    'Fedora': {
      $server_fpinglocation     = '/usr/sbin/fping'
      $server_fping6location    = '/usr/sbin/fping6'
      $proxy_fpinglocation      = '/usr/sbin/fping'
      $proxy_fping6location     = '/usr/sbin/fping6'
      $manage_repo              = false
      $manage_choco             = false
      $zabbix_package_agent     = 'zabbix-agent'
      $agent_configfile_path    = '/etc/zabbix_agentd.conf'
      $agent_config_owner       = 'zabbix'
      $agent_zabbix_user        = 'zabbix'
      $agent_config_group       = 'zabbix'
      $agent_pidfile            = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_servicename        = 'zabbix-agent'
      $agent_include            = '/etc/zabbix/zabbix_agentd.d'
      $server_zabbix_user       = 'zabbix'
      $zabbix_package_provider  = undef
      $agent_loadmodulepath     = '/usr/lib/modules'
    }
    'Gentoo': {
      $server_fpinglocation     = '/usr/sbin/fping'
      $server_fping6location    = '/usr/sbin/fping6'
      $proxy_fpinglocation      = '/usr/sbin/fping'
      $proxy_fping6location     = '/usr/sbin/fping6'
      $manage_repo              = false
      $manage_choco             = false
      $zabbix_package_agent     = 'zabbix'
      $agent_configfile_path    = '/etc/zabbix/zabbix_agentd.conf'
      $agent_config_owner       = 'zabbix'
      $agent_zabbix_user        = 'zabbix'
      $agent_config_group       = 'zabbix'
      $agent_pidfile            = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_servicename        = 'zabbix-agentd'
      $agent_include            = '/etc/zabbix/zabbix_agentd.d'
      $server_zabbix_user       = 'zabbix'
      $zabbix_package_provider  = undef
      $agent_loadmodulepath     = '/usr/lib/modules'
    }
    'windows': {
      $manage_repo             = false
      $manage_choco            = true
      $zabbix_package_agent    = 'zabbix-agent'
      $zabbix_package_provider = 'chocolatey'
      $agent_configfile_path   = 'C:/ProgramData/zabbix/zabbix_agentd.conf'
      $agent_config_owner      = undef
      $agent_zabbix_user       = undef
      $agent_config_group      = undef
      $agent_pidfile           = 'C:/ProgramData/zabbix/zabbix_agentd.pid'
      $agent_servicename       = 'Zabbix Agent'
      $agent_include           = 'C:/ProgramData/zabbix/zabbix_agentd.d'
      $agent_loadmodulepath    = undef
    }
    default  : {
      $server_fpinglocation     = '/usr/sbin/fping'
      $server_fping6location    = '/usr/sbin/fping6'
      $proxy_fpinglocation      = '/usr/sbin/fping'
      $proxy_fping6location     = '/usr/sbin/fping6'
      $manage_repo              = true
      $manage_choco             = false
      $zabbix_package_agent     = 'zabbix-agent'
      $agent_configfile_path    = '/etc/zabbix/zabbix_agentd.conf'
      $agent_config_owner       = 'zabbix'
      $agent_zabbix_user        = 'zabbix'
      $agent_config_group       = 'zabbix'
      $agent_pidfile            = '/var/run/zabbix/zabbix_agentd.pid'
      $agent_include            = '/etc/zabbix/zabbix_agentd.d'
      $agent_servicename        = 'zabbix-agent'
      $server_zabbix_user       = 'zabbix'
      $zabbix_package_provider  = undef
      $agent_loadmodulepath     = '/usr/lib/modules'
    }
  }

  if downcase($facts['kernel']) == 'windows' {
    $zabbix_version = '4.4.5'
  } else {
    $zabbix_version = '5.0'
  }

  $manage_startup_script = downcase($facts['kernel']) ? {
    'windows' => false,
    default   => true,
  }

  $zabbix_package_state                     = 'present'
  $zabbix_proxy                             = 'localhost'
  $zabbix_proxy_ip                          = '127.0.0.1'
  $zabbix_server                            = 'localhost'
  $zabbix_server_ip                         = '127.0.0.1'
  $zabbix_template_dir                      = '/etc/zabbix/imported_templates'
  $zabbix_timezone                          = 'Europe/Amsterdam'
  $zabbix_url                               = 'localhost'
  $zabbix_web                               = 'localhost'
  $zabbix_web_ip                            = '127.0.0.1'
  $manage_database                          = true
  $manage_service                           = true
  $default_vhost                            = false
  $manage_firewall                          = false
  $manage_apt                               = true
  $repo_location                            = undef
  $unsupported_repo_location                = undef
  $frontend_repo_location                   = undef
  $manage_resources                         = false
  $manage_vhost                             = true
  $database_path                            = '/usr/sbin'
  $database_schema_path                     = false
  $database_type                            = 'postgresql'
  $apache_php_always_populate_raw_post_data = '-1'
  $apache_php_max_execution_time            = '300'
  $apache_php_max_input_time                = '300'
  $apache_php_max_input_vars                = 1000
  $apache_php_memory_limit                  = '128M'
  $apache_php_post_max_size                 = '16M'
  $apache_php_upload_max_filesize           = '2M'



  # Agent specific params
  $agent_allowroot                          = '0'
  $agent_buffersend                         = '5'
  $agent_buffersize                         = '100'
  $agent_debuglevel                         = '3'
  $agent_allowkey                           = undef
  $agent_denykey                            = 'system.run[*]'
  $agent_enableremotecommands               = '0'
  $agent_hostmetadata                       = undef
  $agent_hostmetadataitem                   = undef
  $agent_hostname                           = undef
  $agent_hostnameitem                       = 'system.hostname'
  $agent_hostinterface                      = undef
  $agent_hostinterfaceitem                  = undef
  $agent_include_purge                      = true
  $agent_listenip                           = undef
  $agent_listenport                         = '10050'
  $agent_loadmodule                         = undef
  $agent_logremotecommands                  = '0'
  $agent_maxlinespersecond                  = '100'
  $agent_refreshactivechecks                = '120'
  $agent_server                             = '127.0.0.1'
  $agent_serveractive                       = undef
  $agent_service_ensure                     = 'running'
  $agent_service_enable                     = true
  $agent_sourceip                           = undef
  $agent_startagents                        = '3'
  $agent_timeout                            = '3'
  $agent_tlsaccept                          = undef
  $agent_tlscafile                          = undef
  $agent_tlscertfile                        = undef
  $agent_tlsconnect                         = undef
  $agent_tlscrlfile                         = undef
  $agent_tlskeyfile                         = undef
  $agent_tlspskfile                         = undef
  $agent_tlscipherall                       = undef
  $agent_tlscipherall13                     = undef
  $agent_tlsciphercert                      = undef
  $agent_tlsciphercert13                    = undef
  $agent_tlscipherpsk                       = undef
  $agent_tlscipherpsk13                     = undef
  $agent_tlspskidentity                     = undef
  $agent_tlsservercertissuer                = undef
  $agent_tlsservercertsubject               = undef
  $agent_unsafeuserparameters               = '0'
  $agent_use_ip                             = true
  $agent_userparameter                      = undef
  $agent_zabbix_alias                       = undef
  $agent_zbx_group                          = 'Linux servers'
  $agent_zbx_groups                         = ['Linux servers',]
  $agent_zbx_group_create                   = true
  $agent_zbx_templates                      = ['Template OS Linux', 'Template App SSH Service']
  $apache_status                            = false
  $monitored_by_proxy                       = undef
  # provided by camptocamp/systemd
  if $facts['systemd'] {
    $agent_logtype                          = 'system'
    $agent_logfile                          = undef
    $agent_logfilesize                      = undef
  }
  elsif $facts['kernel'] == 'windows' {
    $agent_logtype                          = 'file'
    $agent_logfile                          = 'C:/ProgramData/zabbix/zabbix_agentd.log'
    $agent_logfilesize                      = '100'
  }
  else {
    $agent_logtype                          = 'file'
    $agent_logfile                          = '/var/log/zabbix/zabbix_agentd.log'
    $agent_logfilesize                      = '100'
  }

  # SE Linux specific params
  $selinux_require                          = ['type zabbix_agent_t', 'class process setrlimit', 'class unix_dgram_socket create']
  $selinux_rules                            = { 'zabbix_agent_t' => ['allow zabbix_agent_t self:process setrlimit', 'allow zabbix_agent_t self:unix_dgram_socket create'] }

  $manage_selinux = fact('os.selinux.enabled') ? {
    true    => true,
    default => false,
  }

  $additional_service_params = '--foreground'
  $service_type              = 'simple'

  # the package provider we use to install the zabbixapi gem
  # The puppet agent needs to access it. So it's `puppet_gem` for AIO systems.
  $puppetgem = 'puppet_gem'
}
