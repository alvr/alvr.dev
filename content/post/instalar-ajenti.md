---
title: "Instalar Ajenti"
subtitle: "Aprende a instalar y configurar Ajenti, un panel de administración para manejar y controlar tu VPS."
date: 2014-10-24T15:56:12+02:00
tags: [ "ajenti", "vps", "configurar ajenti", "panel de control" ]
---
Configurar un servidor web no es tarea fácil, sobre todo si no tienes conocimientos suficientes. Los paneles de control nos facilitan el uso de los servidores gracias a su interfaz gráfica. Algunos de los paneles más usados son cPanel, DirectAdmin, Webmin, pero el que utilizo y voy a hablar es de Ajenti.

<!--more-->

Ajenti está escrito en **Python** y cuenta con una interfaz muy sencilla y agradable a la vista. Está dividido en varias secciones, como _Sistema_, _Herramientas_ y _Software_, cada una con sus respectivos módulos. Es compatible con bastantes programas, como **Apache**, **nginx**, **MySQL/MariaDB**, etc... y se puede configurar desde el mismo panel. Además utiliza una conexión **SSL** para aumentar la seguridad de la conexión.

# Instalación
Para poder instalar Ajenti se necesita uno de estos sistemas operativos:

*  Debian 6 o superior
*  Ubuntu 12.04 o superior
*  CentOS 6 o superior / RHEL 6 o superior
*  Raspbian
*  FreeBSD (experimental)

## Instalación en Debian
Se puede instalar con una sola línea:  
{{< highlight bash >}}
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-debian.sh | sh
{{</ highlight >}}

O bien manualmente:
{{< highlight bash >}}
wget http://repo.ajenti.org/debian/key -O- | apt-key add -
echo "deb http://repo.ajenti.org/debian main main debian" >> /etc/apt/sources.list.d/ajenti.list
apt-get update && apt-get install ajenti
service ajenti restart
{{</ highlight >}}

## Instalación en Ubuntu
Se puede instalar con una sola línea:  
{{< highlight bash >}}
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-ubuntu.sh | sudo sh
{{</ highlight >}}

O bien manualmente:
{{< highlight bash >}}
wget http://repo.ajenti.org/debian/key -O- | apt-key add -
echo "deb http://repo.ajenti.org/ng/debian main main ubuntu" >> /etc/apt/sources.list.d/ajenti.list
sudo apt-get update && sudo apt-get install ajenti
sudo service ajenti restart
{{</ highlight >}}

## Instalación en CentOS/RHEL
Se puede instalar con una sola línea:  
Si se usa CentOS 6/RHEL6:  
{{< highlight bash >}}curl https://raw.githubusercontent.com/ajenti/ajenti/1.x/scripts/install-rhel.sh | sh{{</ highlight >}}

Si se usa CentOS 7/RHEL7:  
{{< highlight bash >}}curl https://raw.githubusercontent.com/ajenti/ajenti/1.x/scripts/install-rhel7.sh | sh{{</ highlight >}}

O bien manualmente:
{{< highlight bash >}}
wget http://repo.ajenti.org/ajenti-repo-1.0-1.noarch.rpm 
rpm -i ajenti-repo-1.0-1.noarch.rpm
yum install ajenti
service ajenti restart
{{</ highlight >}}

## Instalación en Raspbian
Se puede instalar con una sola línea:  
{{< highlight bash >}}
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-raspbian.sh | sh
{{</ highlight >}}

O bien manualmente:
{{< highlight bash >}}
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
{{</ highlight >}}

## Instalación en FreeBSD
Prerequisitos:  
{{< highlight bash >}}
cd /usr/ports/devel/py-gevent;  make install clean;
cd /usr/ports/devel/py-lxml;    make install clean;
cd /usr/ports/devel/py-pip;     make install clean;
cd /usr/ports/net/py-ldap2;     make install clean;
cd /usr/ports/devel/libffi;     make install clean;
{{</ highlight >}}

Instalar con:  
{{< highlight bash >}}
pip install ajenti
{{</ highlight >}}  

Instalar script rc.d:  
{{< highlight bash >}}
wget https://raw.github.com/ajenti/ajenti/1.x/packaging/files/ajenti-bsd -O /etc/rc.d/ajenti
{{</ highlight >}}

# Configuración
Una vez que hayamos instalado y accedido con el usuario **root** y contraseña **admin** se nos mostrará una pantalla parecida a esta:  
{{< figure link="/media/instalar-ajenti/ajenti.png" title="Página principal de Ajenti" >}}  
En la pantalla principal nos aparecerá el sistema operativo, así como su versión y widgets que podremos usar para personalizar la pantalla según queramos. También un menú lateral con el que podemos acceder a todos los módulos disponibles.

## Autenticación
Lo primero que vamos a hacer va a ser cambiar la autenticación. Nos dirigimos a **Password** para cambiar la contraseña del administrador, porque sino el servidor sería muy vulnerable. Una vez hecho eso podemos seguir utilizando la cuenta **root** o bien utilizar una cuenta del propio sistema. Lo malo de esto último es que si alguien sabe de algún modo u otro la contraseña del usuario, podría tener acceso por SSH al servidor. Por eso se puede crear un usuario sin acceso SSH con el siguiente comando:  
{{< highlight bash >}}
useradd -s /usr/sbin/nologin <usuario>
{{</ highlight >}}

Después en el menú _Configure_, en el apartado _Sync with_ seleccionamos _OS users_ y reiniciamos Ajenti. Una vez reiniciado actualizamos los permisos haciendo click en el nombre y seleccionándolos.

## BIND
Es el servidor DNS que se suele utilizar y el que viene por defecto en la mayoría de los servidores. Bind se utiliza para apuntar el dominio a la dirección IP. Para configurarlo seleccionamos _BIND9_ en el menú y creamos un nuevo fichero.

* **Name**: Escribimos el dominio, en mi caso _alvr.me_.
* **Type**: _Master_.
* **File**: _/etc/bind/db.&lt;name&gt;._ Siendo &lt;name&gt; el valor del primer campo de texto.
* **Zone**: Podemos utilizar la <a href="http://pgl.yoyo.org/as/bind-zone-file-creator.php" target="_blank">siguiente web</a> para generar el contenido del fichero.

Después de guardar, reiniciamos _bind_: 
{{< highlight bash >}}
service bind9 restart
{{</ highlight >}}

## Otros módulos
Dependiendo del programa que queramos configurar, como por ejemplo nginx, cron, MySQL, etc... hacemos click en el menú correspondiente y editaremos lo necesarios. Está tan bien organizado que es así de sencillo cambiar la configuración.

Y eso es todo, si surge alguna duda o tenéis alguna pregunta, no dudéis en usar los comentarios.