class pnizabbix::params{

$server=lookup('pnizabbix::server')

## by default just listen on all ports - note: this can cause problems if it detects ipv6 capabilities
$agentlistenip=lookup('pnizabbix::agent::listenip',undef,undef,'0.0.0.0')

}
