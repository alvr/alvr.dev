---
title: RandomPtW
subtitle: Don't know what to watch? Well, with this tool you will decide for you
description: Don't know what to watch? Well, with this tool you will decide for you.

date: 2016-09-05T18:00:00+02:00
categories: 
  - PHP
  - Web
tags: 
  - anime
  - random
  - myanimelist

translationKey: randomptw
type: showcase

link: /en/projects/web/randomptw/
repo: https://github.com/alvr/randomptw
---
{{< notice error "Deprecated" >}}
MyAnimeList no longer has the API that was used for this application and all queries will return *Invalid User*.
{{< /notice >}}

If you have a big list of pending anime and you can't decide on one, why not let a piece of code select a random one?

RandomPtW gets your list of pending anime from MyAnimeList and then selects a random one. And if you are not happy, you can always try your luck again.

When you select the anime you will see a poster, the synopsis, and a button to go to the MyAnimeList entry.

Anime that has not yet been broadcast is not taken into account, but sequels are taken into account even without having seen the prequel.

It is written in PHP + jQuery. It uses the [DomCrawler](http://symfony.com/doc/current/components/dom_crawler.html) component from Symfony and the [Materialize](https://getmdl.io/) design. The design is responsible, so it fits the screen of mobile devices.

{{< button href="https://randomptw.alvr.me/" color="primary">}}**Visit RandomPtW**{{</ button >}}
{{< button href="https://github.com/alvr/RandomPtW" color="primary">}}**GitHub**{{</ button >}}
