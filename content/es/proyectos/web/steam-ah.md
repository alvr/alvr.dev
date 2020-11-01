---
title: Steam Achievements Hunter
subtitle: Registro de logros bloqueados y desbloqueados
description: Registro de logros bloqueados y desbloqueados.

date: 2017-07-11T17:14:13+02:00
categories: 
  - Python
  - Web
tags: 
  - steam
  - logros

translationKey: steam-ah
type: page
weight: 4

link: /proyectos/web/steam-ah/
pinned: true
---
{{< notice error "Deprecado" >}}
La nueva interfaz de la biblioteca de Steam permite ordenar juego por porcentaje de logros desbloqueados, ideal para completar primero los juegos que menos logros falten.
{{< /notice >}}

Steam es la plataforma online de videojuegos por excelencia. Muchos de sus usuarios son coleccionistas de juegos y otros intentan conseguir todos los logros posibles.

Para mantener un registro de los logros que faltan por conseguir en algún juego puede ser una tarea muy tediosa, sobre todo si tienes una colección abultada.

La solución sería una lista con el nombre del juego y los logros bloqueados y desbloqueados y para ello he creado una herramienta que simplifica el trabajo.

Tan solo hay que ingresar tu SteamID, ya sea **Steam 64 ID** como [*76561198004956893*](http://steamcommunity.com/profiles/76561198004956893) o la **URL del perfil** como [Alvaro_SG](http://steamcommunity.com/id/Alvaro_SG) y una [clave API](https://steamcommunity.com/dev/apikey).

El proyectos está alojado en OpenShift, por lo que tiene recursos limitados.

{{< button href="https://steam-ah.alvr.me" color="primary" >}}**Visitar SteamAH**{{</ button >}}
