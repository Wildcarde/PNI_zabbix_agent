class pnizabbix::params{

$server=lookup('pnizabbix::server')
#$server=hiera('pnizabbix::server')

## by default just listen on all ports - note: this can cause problems if it detects ipv6 capabilities
$agentlistenip=lookup('pnizabbix::agent::listenip',undef,undef,'0.0.0.0')
#$agentlistenip=hiera('pnizabbix::agent::listenip','0.0.0.0')

}
