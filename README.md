# Quick Zabbix Agent Manager

This package is built on a mountain of assumptions and probably shouldn't be used if you aren't me or my coworkers (for now).

core assumptions:
- you have a repository with a package named `zabbix52_agent2`
- you are probably running centos 7 (or ideally springdale 7)
- you are willing to import a package directly into your puppet env instead of using r10k or the puppet module command