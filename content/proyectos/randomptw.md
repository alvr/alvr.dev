---
title: "RandomPTW"
subtitle: "Anime aleatorio"
date: 2016-09-05T18:00:00+02:00
tags: [ "anime", "myanimelist", "random" ]
---
Si tienes una gran lista de animes pendientes y no te decides por uno, ¿por qué no dejas que un trozo de código seleccione uno aleatorio?

RandomPTW obtiene tu lista de animes pendientes de MyAnimeList y luego selecciona uno aleatorio. Y si no estás conforme, siempre puedes probar suerte otra vez.

<!--more-->

Cuando se seleccione el anime se mostrará un poster, la sinopsis (en inglés), y un botón para ir a la entrada de MyAnimeList.

Los animes que aún no se han emitido no se tienen en cuenta, pero sí las secuelas incluso sin haber visto la precuela de la misma.

Está escrito en PHP + jQuery. Utiliza el componente [DomCrawler](http://symfony.com/doc/current/components/dom_crawler.html) de Symfony y el diseño [Materialize](https://getmdl.io/). El diseño es adaptable, por lo que ajusta a la pantalla de los dispositivos móviles.

![RandomPTW](/media/randomptw/randomptw.png)

<a class="no-underline" href="https://github.com/alvr/RandomPTW" title="Ver en Github">
	<span class="fa-stack fa-lg">
		<i class="fa fa-circle fa-stack-2x"></i>
		<i class="fa fa-github fa-stack-1x fa-inverse"></i>
	</span>
	Github
</a>

<a class="no-underline" href="http://randomptw.herokuapp.com" title="Ver online">
	<span class="fa-stack fa-lg">
		<i class="fa fa-circle fa-stack-2x"></i>
		<i class="fa fa-desktop fa-stack-1x fa-inverse"></i>
	</span>
	Online
</a>