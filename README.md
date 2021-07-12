# Puppet Zabbix Agent
This is built off the vox-poppuli all encompassing [zabbix](https://github.com/voxpupuli/puppet-zabbix) package and is an attempt at only managing agent installs instead of handling everything in one package. The dependencies for this package should be considerably smaller as a result making it easier to integrate into pre-existing puppet setups.


## Overview

This module contains the classes for installing and configuring the following zabbix components:

- zabbix-agent
- zabbix-sender

This readme will contain all basic information to get you started. Some more information can be found on the github wiki, location: https://github.com/voxpupuli/puppet-zabbix/wiki


## Module Description
When using this module, you can monitor your whole environment with zabbix. It can install the various zabbix components like the server and agent, but you will also be able to install specific "userparameter" file which zabbix can use for monitoring.

With the 0.4.0 release, you can - when you have configured exported resources - configure agents and proxies in the webinterface. So when you add an zabbix::agent to an host, it first install the agent onto the host. It will send some data to the puppetdb and when puppet runs on the zabbix-server it will create this new host via the zabbix-api.

Be aware when you have a lot of hosts, it will increase the puppet runtime on the zabbix-server host. It will check via the zabbix-api if hosts exits and costs time.

This module make uses of this gem: https://github.com/express42/zabbixapi
With this gem it is possible to create/update hosts/proxy in ruby easy.

## Usage
The following will provide an basic usage of the zabbix components.

### Usage zabbix-agent

Basic one way of setup, wheter it is monitored by zabbix-server or zabbix-proxy:
```ruby
class { 'zabbix::agent':
  server => '192.168.20.11',
}
```
### Usage zabbix-sender

The zabbix-sender installation is quite simple and straightforward:
```ruby
include zabbix::sender
```

## Zabbix Upgrades

It is possible to do upgrades via this module. An example for the zabbix agent:

```puppet
class{'zabbix::agent':
  zabbix_version => '2.4',
  manage_repo    => true,
}
```

This will install the latest zabbix 2.4 agent for you. The module won't to any upgrades nor install patch releases. If you want to get patch releases automatically:

```puppet
class{'zabbix::agent':
  zabbix_version       => '2.4',
  manage_repo          => true,
  zabbix_package_state => 'latest',
}
```

Let's assume zabbix just released version 3.4. Than you can do upgrades as follow:
```puppet
class{'zabbix::agent':
  zabbix_version       => '3.4',
  manage_repo          => true,
  zabbix_package_state => 'latest',
}
```

You can also tell the module to only create the new repository, but not to update the existing agent:

```puppet
class{'zabbix::agent':
  zabbix_version       => '3.4',
  manage_repo          => true,
  zabbix_package_state => 'installed',
}
```

Last but not least you can disable the repo management completely, which will than install zabbix from the present system repos:

```puppet
class{'zabbix::agent':
  manage_repo          => false,
  zabbix_package_state => 'present',
}
```

Even in this scenario you can do automatic upgrades via the module (it is the job of the user to somehow bring updates into the repo, for example by managing the repo on their own):

```puppet
class{'zabbix::agent':
  manage_repo          => false,
  zabbix_package_state => 'latest',
}
```

## Reference
There are some overall parameters which exists on all of the classes:
* `zabbix_version`: You can specify which zabbix release needs to be installed. Default is '3.0'.
* `manage_firewall`: Wheter you want to manage the firewall. If true, iptables will be configured to allow communications to zabbix ports. (Default: False)
* `manage_repo`:  If zabbix needs to be installed from the zabbix repositories (Default is true). When you have your own repositories, you'll set this to false. But you'll have to make sure that your repository is installed on the host.

The following is only availabe for the following classes: zabbix::web, zabbix::proxy & zabbix::agent
* `manage_resources`: As of release 0.4.0, when this parameter is set to true (Default is false) it make use of exported resources. You'll have an puppetdb configured before you can use this option. Information from the zabbix::agent, zabbix::proxy and zabbix::userparameters are able to export resources, which will be loaded on the zabbix::server.
* `database_type`: Which database is used for zabbix. Default is postgresql.
* `manage_database`: When the parameter 'manage_database' is set to true (Which is default), it will create the database and loads the sql files. Default the postgresql will be used as backend, mentioned in the params.pp file. You'll have to include the postgresql (or mysql) module yourself, as this module will require it.
### Reference zabbix-agent
* `server`: This is the ipaddress of the zabbix-server or zabbix-proxy.
* `allowkey`: Allows execution of item keys matching pattern.
* `denykey`: Deny execution of items keys matching pattern.
* `tlsaccept`: What incoming connections to accept from Zabbix server. Used for a passive proxy, ignored on an active proxy.
* `tlscafile`: Full pathname of a file containing the top-level CA(s) certificates for peer certificate verification.
* `tlscertfile`: Full pathname of a file containing the proxy certificate or certificate chain.
* `tlsconnect`: How the proxy should connect to Zabbix server. Used for an active proxy, ignored on a passive proxy.
* `tlscrlfile`: Full pathname of a file containing revoked certificates.
* `tlskeyfile`: Full pathname of a file containing the proxy private key.
* `tlspskfile`: Full pathname of a file containing the pre-shared key.
* `tlspskidentity`: Unique, case sensitive string used to identify the pre-shared key.
* `tlsservercertissuer`: Allowed server certificate issuer.
* `tlsservercertsubject`: Allowed server certificate subject.

The following parameters is only needed when `manage_resources` is set to true:
* `monitored_by_proxy`: When an agent is monitored via an proxy, enter the name of the proxy. The name is found in the webinterface via: Administration -> DM. If it isn't monitored by an proxy or `manage_resources` is false, this parameter can be empty.
* `agent_use_ip`: Default is set to true. Zabbix server (or proxy) will connect to this host via ip instead of fqdn. When set to false, it will connect via fqdn.
* `zbx_groups`: An array of hostgroups where this host needs to be added. Default (Array): 'Linux servers'
* `zbx_group_create`: Default is set to true. Creates the Host Groups in Zabbix when they do not exist yet. When set to false you have to make sure the Host Group exists in Zabbix
* `zbx_templates`: Name of the templates which will be assigned when agent is installed. Default (Array): 'Template OS Linux', 'Template App SSH Service'

There are some more zabbix specific parameters, please check them by opening the manifest file.

## Limitations

This module supports Zabbix 4.0, 5.0 and 5.2. The upstream supported versions are documented [here](https://www.zabbix.com/de/life_cycle_and_release_policy)
Please have a look into the metadata.json for all supported operating systems.

This module is supported on both the community and the Enterprise version of Puppet.

Please be aware, that when manage_resources is enabled, it can increase an puppet run on the zabbix-server a lot when you have a lot of hosts.

## Contributors

**ericsysmin** will be helping and maintaining this puppet module. In Github terms he is an Collaborator. So don't be suprised if he acceps/rejects Pull Requests and comment in issues.

The following have contributed to this puppet module:

 * Suff
 * gattebury
 * sq4ind
 * nburtsev
 * actionjack
 * karolisc
 * lucas42
 * f0
 * mmerfort
 * genebean
 * meganuke19
 * fredprod
 * ericsysmin
 * JvdW
 * rleemorlang
 * genebean
 * exptom
 * sbaryakov
 * roidelapluie
 * andresvia
 * ju5t
 * elricsfate
 * IceBear2k
 * altvnk
 * rnelson0
 * hkumarmk
 * Wprosdocimo
 * 1n
 * szemlyanoy
 * Wprosdocimo
 * sgnl05
 * hmn
 * BcTpe4HbIu
 * mschuett
 * claflico
 * bastelfreak
 * Oyabi
 * akostetskiy
 * DjxDeaf
 * tcatut
 * inspired-geek
 * ekohl
 * z3rogate
 * mkrakowitzer
 * eander210
 * hkumarmk
 * ITler
 * slashr00t
 * channone-arif-nbcuni
 * BcTpe4HbIu
 * vide

Many thanks for this!
(If I have forgotten you, please let me know and put you in the list of fame. :-))

## Note
### Standard usage
*	Not specified as required but for working correctly, the epel repository should be available for the 'fping'|'fping6' packages.
*	Make sure you have sudo installed and configured with: !requiretty.

### SE Linux

On systems with SE Linux active and enforcing, Zabbix agent will be limited unless given proper rights with an SE Linux module.
This Puppet module will apply some default SE Linux rules for it.
More can be provided if needed by using two class parameters, for example in Hiera YAML:

```yaml
zabbix::agent::selinux_require:
  - 'type zabbix_agent_t'
  - 'class process setrlimit'
zabbix::agent::selinux_rules:
  zabbix_agent_t:
    - 'allow zabbix_agent_t self:process setrlimit'
  zabbix_script_t:
    - 'allow zabbix_script_t zabbix_agent_t:process sigchld'
```

### When using exported resources

At the moment of writing, the puppet run will fail one or more times when `manage_resources` is set to true when you install an fresh Zabbix server. It is an issue and I'm aware of it. Don't know yet how to solve this, but someone suggested to try puppet stages and for know I haven't made it work yet.

*	Please be aware, that when `manage_resources` is enabled, it can increase an puppet run on the zabbix-server a lot when you have a lot of hosts. You also need to ensure that you've got ruby installed on your machine, and related packages to compile native extensions for gems (usually gcc and make).
*	First run of puppet on the zabbix-server can result in this error:

```ruby
Error: Could not run Puppet configuration client: cannot load such file -- zabbixapi
Error: Could not run: can't convert Puppet::Util::Log into Integer
```

See: http://comments.gmane.org/gmane.comp.sysutils.puppet.user/47508, comment:  Jeff McCune | 20 Nov 20:42 2012

```quote
This specific issue is a chicken and egg problem where by a provider needs a gem, but the catalog run itself is the thing that provides the gem dependency. That is to say, even in Puppet 3.0 where we delay loading all of the providers until after pluginsync finishes, the catalog run hasn't yet installed the gem when the provider is loaded.

The reason I think this is basically a very specific incarnation of #6907 is because that ticket is pretty specific from a product functionality perspective, "You should not have to run puppet twice to use a provider."
```

After another puppet run, it will run succesfully.

* On a Red Hat family server, the 2nd run will sometimes go into error:

```ruby
Could not evaluate: Connection refused - connect(2)
```

When running puppet again (for 3rd time) everything goes fine.
