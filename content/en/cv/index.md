---
title: CV
date: 2013-01-11T12:00:00+01:00
description: Curriculum vitae of Álvaro Salcedo García
type: resume
enableToc: false
translationKey: cv

header:
  infos:
    name: Álvaro Salcedo García
    website: https://alvr.me/docs/cv.en.pdf

items:
  - title: Professional Experience
    sections:
      - title: Android Developer
        subtitle: Babel Sistemas de Información
        startDate: 2019-02-11
        endDateText: present
        contents: | 
          Currently working mainly in two projects of Santander Deutschland performing maintenance and evolution of both applications. Occasionally in projects of other customers. Regarding the applications of Santander Deutschland:
          
          * I improved the stability of the application by increasing the percentage of error-free sessions from 82% to 99.4% in two months.
          * I increased the code coverage from 37% to 81% by doing instrumental and unit tests.
          * Code refactoring: increase readability and improve the structure of the code; technical and functional documentation; improvements in smoothness and speed.
          * I improved the security and integrity of the application by performing actions such as: encrypting sensitive user information, avoiding the use of modified devices and code obfuscation.
          * I created two data mocks, one static and one dynamic. I made them because of the limitations to connect to pre-production environments. Both are written in Golang.

  - title: Education
    sections:
      - title: Software Engineerning
        subtitle: ETSISI (UPM)
        startDate: 2014-09-01
        endDate: 2019-07-31
        contents: | 
          Final Degree Project: [Pressurizer](/docs/pressurizer.pdf) (only in Spanish). Published under the license [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/deed.en). Also available on the [Archivo Digital](http://oa.upm.es/55657/) of the UPM.

  - title: Certificates
    sections:
      - title: Associate Android Developer
        titleLink: https://www.credential.net/6c7cb064-46a5-405c-a16b-f8e0f95355ce
        linkNewPage: true
        subtitle: Google Developers
        startDate: 2020-09-10
        endDate: 2023-09-10

  - title: Projects
    sections:
      - title: Alpine Android
        titleLink: /en/projects/docker/alpine-android/
        subtitle: Lightweight Docker image for testing and compiling Android applications
        startDate: 2017-03-17
        endDateText: present
        contents: |
          Docker image based on Alpine Linux for testing and compiling Android applications. Thanks to Alpine you can get a lighter and less heavy image than Debian/Ubuntu based images. The base image in Alpine is [244.02MB](https://hub.docker.com/r/alvrme/alpine-android-base/tags), while in Debian/Ubuntu it is 1.1GB. The final size of the latest Android 11 image is [487.78MB](https://hub.docker.com/r/alvrme/alpine-android/tags).
          
          There are several versions available: from Lollipop to Android 11.
          
          It has 71,000+ downloads from [Docker](https://hub.docker.com/r/alvrme/alpine-android/) and 100+ stars in [GitHub](https://github.com/alvr/alpine-android).

      - title: Pressurizer
        titleLink: /en/projects/web/pressurizer/
        subtitle: Steam library expense management
        startDate: 2018-11-01
        endDate: 2019-06-30
        contents: |
          The functionality of this application is to give the possibility to keep track of the expenses made by the users of the Steam platform.

          This project is divided into two parts. The [server part](https://github.com/alvr/pressurizer-server), written in Kotlin, using the Ktor web framework and the PostgreSQL database. On the other hand, the [client part](https://github.com/alvr/pressurizer-client) is written in TypeScript and Vue.js.

      - title: PkmnDex
        titleLink: /en/projects/android/pkmndex/
        subtitle: Pocket Pokédex for Android phones
        startDate: 2013-07-01
        endDate: 2016-12-31
        contents: |
          Developed in Java and without previous knowledge of Android. A simple application that showed the list of all available Pokémon up to the 7th generation and gave you the possibility to visit different websites to see the information.

          Currently unpublished from Google Play, it reached more than 700,000 downloads with a rating of 4.02.
---