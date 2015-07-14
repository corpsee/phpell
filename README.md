PHPell
======

PHPell is an open source [Vagrant](https://www.vagrantup.com) VM configuration with bash(sh) provision for PHP development.

It was inspired by [PuPHPet](http://puphpet.com) and [Phansible](http://phansible.com).

PHPell includes:

* Vagrant VM with Ubuntu 14.10 and bash(shell) provision.
* Oracle Java 8 (6, 7);
* Apache 2.4;
* PHP 5.6 (5.5, 5.6)
    * Apache2 + php_mod,
    * Nginx + Apache2 + php_mod,
    * Nginx + PHP-FPM;
* Nginx 1.7 (1.6);
* MySQL 5.6 (5.6);
* MariaDB 10.0 (5.5);
* PostgreSQL 9.4 (9.3);
* Memcached 1.4 (+ Memcache/Memcached PHP extensions);

TODO
----

* Add Redis;
* Add MongoDB;
* Add HHVM

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

###Helpers

In the VM you can use helpers for virtual hosts and databases management:

1. Helper `create-host` create new host and new user (has name as new host) and `create-web-user` create only new user:
    
    ```bash
    sudo create-host --host=example.local --password=password_for_example
    sudo create-web-user --user=example.local --password=password_for_example
    ```

2. Helper `enable-host` enable host:

    ```bash
    sudo enable-host --host=example.local
    ```

3. Helper `disable-host` disable host:

    ```bash
    sudo disable-host --host=example.local
    ```

4. Helper `create-mysql-db` create new empty MySQL DB with granted user:

    ```bash
    create-mysql-db --database=example_db --user=example.local --password=password_for_example --root=root_password
    mysql -u example.local -ppassword_for_example -D example_db
    ```

5. Helper `backup-mysql-db` zip and backup MySQL DB to `/var/backups/example.local` directory:

    ```bash
    backup-mysql-db --database=example_db --user=example.local --password=password_for_example
    ```

6. Helper `create-postgres-db` create new empty Postgres DB with granted user:

    ```bash
    sudo create-postgres-db --database=example_db --user=example.local --password=password_for_example
    sudo -u example.local psql -U example.local -d example_db
    ```

7. Helper `backup-postgres-db` zip and backup PostgreSQL DB to `/var/backups/example.local` directory:

    ```bash
    sudo -u example.local backup-postgres-db --database=example_db --user=example.local
    ```

License
-------

The PHPell is open source software licensed under the GPL-3.0 license.
