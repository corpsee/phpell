PHPell
======

PHPell is an open source [Vagrant](https://www.vagrantup.com) VM configuration with bash(sh) provision for PHP development.

It was inspired by [PuPHPet](http://puphpet.com) and [Phansible](http://phansible.com).

PHPell includes:

* Vagrant VM with Ubuntu 14.04 and bash(sh) provision.
* Oracle Java 6|7|8;
* Latest Apache 2.4;
* PHP 5.4|5.5|5.6;
* Latest Nginx;
* MySQL 5.5|5.6;
* MariaDB 10;
* PostgreSQL 9.3|9.4;

TODO
----

* Migrate to Ubuntu 14.10
* Add Memcached;
* Add Redis;
* Add MongoDB;
* Add Nginx + PHP-FPM;

Installation
------------

1. Edit configuration in Vagrantfile and config.sh

2. Install Vagrant VM from console:

```bash
cd /path/to/your/phpell
vagrant up
```

Usage
-----

Run Vagrant VM from console:

```bash
cd /path/to/your/phpell
vagrant ssh
```

In the VM you can use helpers for virtual hosts: create-host, enable-host, disable-host. For example:

```bash
sudo create-host example.local
sudo enable-host example.local
```

License
-------

The PHPell is open source software licensed under the GPLv3 license.