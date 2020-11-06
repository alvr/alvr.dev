---
title: CV
date: 2013-01-11T12:00:00+01:00
description: Curriculum vitae de Álvaro Salcedo García
type: resume
enableToc: false
translationKey: cv

header:
  infos:
    name: Álvaro Salcedo García
    website: https://alvr.me/docs/cv.es.pdf

items:
  - title: Experiencia Laboral
    sections:
      - title: Desarrollador Android
        subtitle: Babel Sistemas de Información
        startDate: 2019-02-11
        endDateText: presente
        contents: | 
          Actualmente trabajando principalmente en dos proyectos de Santander Deutschland realizando mantenimiento y evolutivos de ambas aplicaciones. De vez en cuando en proyectos de otros clientes. Respecto a las aplicaciones de Santander Deutschland:
          
          * Mejoré la estabilidad de la aplicación aumentado el porcentaje de sesiones libre de fallos del 82% al 99.4% en dos meses.
          * Aumenté la cobertura de código de un 37% a un 81% realizando tests instrumentales y unitarios.
          * Refactorización de código: aumentar la legibilidad y mejorar la estructura del mismo; documentación técnica y funcional; mejoras de fluidez y rapidez.
          * Mejoré la seguridad e integridad de la aplicación realizando acciones tales como: encriptar información sensible del usuario, evitar la utilización de dispositivos modificados y ofuscación de código.
          * Creé dos mock de datos, uno de ellos estático y otro dinámico. Los realicé debido a las limitaciones para conectarse a los entornos de preproducción. Ambos están escritos en Golang.

  - title: Educación
    sections:
      - title: Ingeniería del Software
        subtitle: ETSISI (UPM)
        startDate: 2014-09-01
        endDate: 2019-07-31
        contents: | 
          Trabajo de Fin de Grado: [Pressurizer](/docs/pressurizer.pdf) (sólo en español). Publicado bajo la licencia [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es_ES). También está disponible en el [Archivo Digital](http://oa.upm.es/55657/) de la UPM.


  - title: Certificados
    sections:
      - title: Associate Android Developer
        titleLink: https://www.credential.net/6c7cb064-46a5-405c-a16b-f8e0f95355ce
        linkNewPage: true
        subtitle: Google Developers
        startDate: 2020-09-10
        endDate: 2023-09-10

  - title: Proyectos
    sections:
      - title: Alpine Android
        titleLink: /proyectos/docker/alpine-android/
        subtitle: Imagen de Docker ligera para testear y compilar aplicaciones de Android
        startDate: 2017-03-17
        endDateText: presente
        contents: |
          Imagen de Docker basada en Alpine Linux para testear y compilar aplicaciones de Android. Gracias a Alpine se puede obtener una imagen liviana y menos pesada que imágenes basadas en Debian/Ubuntu. La imagen base en Alpine son [781.16MB](https://hub.docker.com/layers/alvrme/alpine-android-base/latest/images/sha256:6c62ac3bc926a73a20426c019a33dd7433a441644c7601cbcb3cc987b2e57a77), mientras que en Debian/Ubuntu son 1.1GB. El tamaño final de la última versión de Android 11 es [1.24GB](https://hub.docker.com/layers/alvrme/alpine-android/latest/images/sha256:c517d2b93d348c4977d373b5d6ce2240e76319e700d55b068fec54515a1fe78c).
          
          Hay varias versiones disponibles: desde Lollipop hasta Android 11.
          
          Cuenta con 70.000+ descargas desde [Docker](https://hub.docker.com/r/alvrme/alpine-android/) y 100+ estrellas en [GitHub](https://github.com/alvr/alpine-android).

      - title: Pressurizer
        titleLink: /proyectos/web/pressurizer/
        subtitle: Gestión de gastos de bibliotecas de Steam
        startDate: 2018-11-01
        endDate: 2019-06-30
        contents: |
          La funcionalidad de esta aplicación es dar la posibilidad de llevar un control de los gastos realizados por los usuarios de la plataforma de videojuegos Steam.

          Este proyecto está dividido en dos partes. La [parte de servidor](https://github.com/alvr/pressurizer-server), escrita en Kotlin, utilizando el framework web Ktor y la base de datos PostgreSQL. Por otro lado, [la parte cliente](https://github.com/alvr/pressurizer-client) está escrita en TypeScript y Vue.js.

      - title: PkmnDex
        titleLink: /proyectos/android/pkmndex/
        subtitle: Pokédex de bolsillo para móviles Android
        startDate: 2013-07-01
        endDate: 2016-12-31
        contents: |
          Desarrollada en Java y sin conocimientos previos de Android. Una simple aplicación que mostraba la lista de todos los Pokémon disponibles hasta la 7ª generación y te daba la posibilidad de visitar diferentes páginas web para ver la información.

          Actualmente despublicada de Google Play, llegó a tener más de 700.000 descargas con una valoración de 4.02.
---