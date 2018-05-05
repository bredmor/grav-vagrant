# Grav-Vagrant

A very simple Ubuntu distribution configured with Apache, PHP and all necessary modules to serve the [grav CMS](https://getgrav.org) locally.

Uses the [ubuntu/xenial64](https://app.vagrantup.com/ubuntu/boxes/xenial64) public vagrant box. 

All provisioning is done via bootstrap.sh

## Prerquisites

1. Have [Vagrant](https://www.vagrantup.com/) installed on your local machine and available via PATH.

## Usage

### 1. Clone this repository
`git clone https://github.com/bredmor/grav-vagrant.git`

### 2. Install grav
`composer create-project getgrav/grav grav-vagrant/grav`

OR if you don't have composer: 

Follow an alternative installation method from the [grav documentation](https://learn.getgrav.org/basics/installation) and ensure that the root of the installation is at `grav-vagrant/grav`

### 3. Run vagrant
`vagrant up`

### 4. That's it!
Your new grav install should be fully operational at [http://127.0.0.1:8080](http://127.0.0.1:8080)

![grav home page](https://i.imgur.com/KKW9LzV.png)

Any edits you make to your local installation at `grav-vagrant/grav` will be immediately reflected upon reloading the page.


---

## Notes

If you need to use a different port than our default of 8080 for any reason (like collision with an existing service), simply edit the `host` variable in `VagrantFile` in this line: 

`config.vm.network "forwarded_port", guest: 80, host: 8080`

-

For proper URL routing, you may need to update the apache configuration at `/etc/apache2/sites-available/000-default.conf` with this extra Directory config:

```
<Directory /var/www/html>
    AllowOverride All
    Require all granted
</Directory>
```
