---
title: RandomPtW
subtitle: ¿No sabes qué anime ver? Pues con esta herramienta decidirá uno por ti
description: ¿No sabes qué anime ver? Pues con esta herramienta decidirá uno por ti.

date: 2016-09-05T18:00:00+02:00
categories: 
  - PHP
  - Web
tags: 
  - anime
  - aleatorio
  - myanimelist

translationKey: randomptw
type: page
weight: 3

link: /proyectos/web/randomptw/
repo: https://github.com/alvr/randomptw
pinned: true
---
{{< notice error "Deprecado" >}}
MyAnimeList ya no tiene disponible el API que se utilizaba para esta aplicación y todas las consultas devolerán *Invalid User*.
{{< /notice >}}

Si tienes una gran lista de animes pendientes y no te decides por uno, ¿por qué no dejas que un trozo de código seleccione uno aleatorio?

RandomPtW obtiene tu lista de animes pendientes de MyAnimeList y luego selecciona uno aleatorio. Y si no estás conforme, siempre puedes probar suerte otra vez.

Cuando se seleccione el anime se mostrará un poster, la sinopsis (en inglés), y un botón para ir a la entrada de MyAnimeList.

Los animes que aún no se han emitido no se tienen en cuenta, pero sí las secuelas incluso sin haber visto la precuela de la misma.

Está escrito en PHP + jQuery. Utiliza el componente [DomCrawler](http://symfony.com/doc/current/components/dom_crawler.html) de Symfony y el diseño [Materialize](https://getmdl.io/). El diseño es adaptable, por lo que ajusta a la pantalla de los dispositivos móviles.

{{< button href="https://randomptw.herokuapp.com/" color="primary">}}**Visitar RandomPtW**{{</ button >}}
{{< button href="https://github.com/alvr/RandomPtW" color="primary">}}**GitHub**{{</ button >}}
