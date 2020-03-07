[![Build Status - Master](https://travis-ci.org/juju4/ansible-logger.svg?branch=master)](https://travis-ci.org/juju4/ansible-logger)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-logger.svg?branch=devel)](https://travis-ci.org/juju4/ansible-logger/branches)
# DetectionLab Linux logger ansible role

Setup a Linux Logger for [DetectionLab](https://github.com/clong/DetectionLab)

WARNING! Work in progress.

## Requirements & Dependencies

### Ansible

Tested with Ansible 2.9

### Operating systems

Targeted for Ubuntu.
May be usable on other Linux (future)

### Dependencies

```
$ ansible-galaxy install -r requirements.yml
```

* juju4.kolide
* juju4.zeek
* mrlesmithjr.suricata
* mrlesmithjr.guacamole

## Example Playbook

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: juju4.logger, x: 42 }

## Continuous integration

You can use molecule to test this role

```
$ pip3 install molecule docker
$ molecule test
$ MOLECULE_NO_LOG="false" MOLECULE_DISTRO=ubuntu:18.04 molecule test --destroy=never
```

or with kitchen (with lxd; better for systemd services)
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync
$ cd /path/to/roles/juju4.logger
$ kitchen verify
$ kitchen login
```

## License

BSD 2-clause
