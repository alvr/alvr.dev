---
title: Install Ajenti
subtitle: Learn how to install and configure Ajenti, an administration panel to manage and control your VPS
description: Learn how to install and configure Ajenti, an administration panel to manage and control your VPS.

date: 2014-10-24T15:56:12+02:00
categories:
  - Server
tags:
  - ajenti
  - vps
  - configure ajenti
  - control panel

image: /images/posts/2014/ajenti/logo.webp
translationKey: install-ajenti
slug: install-ajenti
---
Setting up a web server is not an easy task, especially if you don't have enough knowledge. The control panels make it easy to use the servers thanks to their graphic interface. Some of the most used panels are cPanel, DirectAdmin, Webmin, but the one I use and will talk about is Ajenti.

<!--more-->

Ajenti is written in **Python** and has a very simple and pleasing interface. It is divided in several sections, like _System_, _Tools_ and _Software_, each one with its respective modules. It is compatible with many programs, such as **Apache**, **nginx**, **MySQL/MariaDB**, etc... and can be configured from the same panel. It also uses a **SSL** connection to increase the security of the connection.

## Installation

You need one of these operating systems to install Ajenti:

* Debian 6 or higher
* Ubuntu 12.04 or higher
* CentOS 6 or higher / RHEL 6 or higher
* Raspbian
* FreeBSD (experimental)

### Installation in Debian

It can be installed with only one line:

```shell
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-debian.sh | sh
```

Or manually:

```shell
wget http://repo.ajenti.org/debian/key -O- | apt-key add -
echo "deb http://repo.ajenti.org/debian main main debian" >> /etc/apt/sources.list.d/ajenti.list
apt-get update && apt-get install ajenti
service ajenti restart
```

### Installation in Ubuntu

It can be installed with only one line:

```shell
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-ubuntu.sh | sudo sh
```

Or manually:

```shell
wget http://repo.ajenti.org/debian/key -O- | apt-key add -
echo "deb http://repo.ajenti.org/ng/debian main main ubuntu" >> /etc/apt/sources.list.d/ajenti.list
sudo apt-get update && sudo apt-get install ajenti
sudo service ajenti restart
```

### Installation in CentOS/RHEL

It can be installed with only one line:
If you use CentOS 6/RHEL6:

```shell
curl https://raw.githubusercontent.com/ajenti/ajenti/1.x/scripts/install-rhel.sh | sh
```

If you use CentOS 7/RHEL7:

```shell
curl https://raw.githubusercontent.com/ajenti/ajenti/1.x/scripts/install-rhel7.sh | sh
```

Or manually:

```shell
wget http://repo.ajenti.org/ajenti-repo-1.0-1.noarch.rpm
rpm -i ajenti-repo-1.0-1.noarch.rpm
yum install ajenti
service ajenti restart
```

### Installation in Raspbian

It can be installed with only one line:

```shell
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-raspbian.sh | sh
```

Or manually:

```shell
wget http://repo.ajenti.org/debian/key -O- | apt-key add -
echo "deb http://repo.ajenti.org/debian main main debian" >> /etc/apt/sources.list.d/ajenti.list
apt-get update
apt-get install -y ajenti
apt-get install python-pip
apt-get install python-dev
apt-get install libevent-dev
pip install -U gevent
pip install greenlet==dev
pip install -U psutil
/etc/init.d/ajenti restart
service ajenti restart
```

### Installation in FreeBSD

Requirements:

```shell
cd /usr/ports/devel/py-gevent;  make install clean;
cd /usr/ports/devel/py-lxml;    make install clean;
cd /usr/ports/devel/py-pip;     make install clean;
cd /usr/ports/net/py-ldap2;     make install clean;
cd /usr/ports/devel/libffi;     make install clean;
```

Install with:

```shell
pip install ajenti
```

Install rc.d script:

```shell
wget https://raw.github.com/ajenti/ajenti/1.x/packaging/files/ajenti-bsd -O /etc/rc.d/ajenti
```

## Configuration

Once we have installed and accessed with the user **root** and password **admin** we will be shown a screen similar to this one:

{{< img src="/images/posts/2014/ajenti/ajenti.webp" caption="Ajenti Home Page" width="768px" alt="Ajenti Home Page" position="center" >}}

On the main screen, the operating system will appear, as well as its version and widgets that we can use to customize the screen as we want. Also a side menu with which we can access all the available modules.

### Authentication

The first thing we are going to do is change the authentication. We go to **Password** to change the administrator's password, because otherwise the server would be very vulnerable. Once this has been done, we can continue using the **root** account or use an account from the system itself. The bad thing about the latter is that if someone knows in some way or another the user's password, they could have access to the server via SSH. That's why you can create a user without SSH access with the following command:

```shell
useradd -s /usr/sbin/nologin <user>
```

Then in the menu _Configure_, in the section _Sync with_ we select _OS users_ and restart Ajenti. Once restarted we update the permissions by clicking on the name and selecting them.

### BIND

This is the DNS server that is usually used and the one that comes by default in most servers. Bind is used to point the domain to the IP address. To configure it, select _BIND9_ from the menu and create a new file.

* **Name**: We write the domain, in my case _alvr.dev_.
* **Type**: _Master_.
* **File**: _/etc/bind/db.&lt;name&gt;._ Being &lt;name&gt; the value of the first text field.
* **Zone**: We can use the [next web](http://pgl.yoyo.org/as/bind-zone-file-creator.php) to generate the content of the file.

After saving, we restart _bind_:

```shell
service bind9 restart
```

### Other modules

Depending on the program we want to configure, such as nginx, cron, MySQL, etc... we click on the corresponding menu and edit the necessary. It is so well organized that it is that easy to change the configuration.

And that's all, if any doubt arises or you have any questions, don't hesitate to use the comments.
