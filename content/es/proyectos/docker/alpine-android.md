---
title: Alpine Android
subtitle: 🐋 Imagen de Docker ligera para compilar y testear aplicaciones de Android
description: 🐋 Imagen de Docker ligera para compilar y testear aplicaciones de Android.

date: 2017-03-29T22:44:00+02:00
categories: 
  - Android
  - Docker
tags: 
  - alpine
  - cd
  - ci
  - ci/cd
  - despliegue continuo
  - integración continua
  - google play

translationKey: alpine-android
type: showcase

link: /proyectos/docker/alpine-android/
repo: https://github.com/alvr/alpine-android
image: /images/showcase/alpine-android/docker-android.png
thumb: /showcase/alpine-android/docker-android.png

shields:
- name: Docker Pulls
  image: https://img.shields.io/docker/pulls/alvrme/alpine-android.svg
  link: https://hub.docker.com/r/alvrme/alpine-android/
- name: Docker Stars
  image: https://img.shields.io/docker/stars/alvrme/alpine-android.svg
  link: https://hub.docker.com/r/alvrme/alpine-android/
- name: Image Size
  image: https://img.shields.io/badge/487.78MB-21%20layers-blue
  link: https://hub.docker.com/r/alvrme/alpine-android/tags
- name: GitHub Stars
  image: https://img.shields.io/github/stars/alvr/alpine-android.svg
  link: https://github.com/alvr/alpine-android/stargazers
---
{{< featuredImage alt="Alpine Android" width=450 height=253 >}}

## Descripción

Alpine Android es una ligera imagen de Docker para compilar y testear aplicaciones Android. Basada en la imagen de Alpine, hace que el tamaño se reduzca comparado con imágenes basadas en Debian o Ubuntu. Además, hay imágenes distintas por cada SDK y sólo se incluyen los paquetes mínimos.

Están disponibles las versiones del SDK desde Android 21 hasta Android 30. Cada versión del SDK tiene su propia imagen, siendo el identificador `alvrme/alpine-android:android-<version>`. Si siempre quieres hacer referencia a la última versión estable de Android que se encuentre disponible, se puede usar también `alvrme/alpine-android:latest`. Hay que tener en cuenta de que cuando se publique la versión 31 del SDK, si quieres seguir usando la 30, es mejor usar la etiqueta identificativa de la versión.

{{< notice info "Versionado" >}}
Hay que tener en cuenta de que cuando se publique la versión 31 del SDK, si quieres seguir usando la 30, es mejor usar la etiqueta identificativa de la versión.
{{< /notice >}}

## Alpine Android Base

Todas las imágenes extienden de una imagen base. Esta imagen basada en [AdoptOpenJDK8 Alpine](https://hub.docker.com/r/adoptopenjdk/openjdk8), contiene las herramientas básicas y necesarias para compilar y testear cualquier aplicación o biblioteca Android cuyo `compileSdkVersion` se encuentre entre la versión 21 (Android 5 / Lollipop) y la versión 30 (Android 11).

Esto facilita la actualización de las imágenes que extienden de ella, ya que sólo habría que modificar el `Dockerfile` necesario.

### Usar como imagen base

Para extender de la imagen base y poder configurar tu propia imagen con los paquetes y aplicaciones que desees, sólo hay que añadir la siguiente línea al principio de `Dockerfile`:

```dockerfile
FROM alvrme/alpine-android-base
```

### Instalar aplicaciones y paquetes

Se puede instalar cualquier aplicación de Alpine de la [siguiente lista](https://pkgs.alpinelinux.org/packages?name=&branch=v3.12&arch=x86_64) añadiendo el siguiente comando al `Dockerfile`:

```dockerfile
RUN apk add --no-cache <paquete1> <paquete2> <...> && \
    rm -rf /tmp/* /var/tmp/*
```

De igual forma, puedes instalar cualquier [paquete disponible](https://gist.github.com/alvr/8db356880447d2c4bbe948ea92d22c23) de Android:

```dockerfile
RUN sdkmanager --sdk_root=${ANDROID_HOME} --install <paquete1> <paquete2> <...>
```

## Herramientas incluidas

A continuación se lista todas las herramientas incluídas con la instalación de los diferentes paquetes. Aquellos que tengan documentación propia están enlazados.

{{< notice info "Gradle" >}}
No está instalado el paquete `gradle`, por lo que no está disponible el comando en el `PATH`. El motivo de esto es que el paquete puede estar desactualizado y no ser compatible con alguna de las APIs utilizadas en la configuración. Es por eso que se debe de usar siempre el _wrapper_ que viene en el proyecto y cuya versión está indicada en el fichero `gradle-wrapper.properties`. Puedes consultar [aquí](#usar-en-diferentes-cicd) como configurar el _wrapper_ para usarlo en los distintos servicios de CI/CD.
{{< /notice >}}

### Línea de comandos

<!-- markdownlint-disable MD033 -->
* <code>[apkanalyzer](https://developer.android.com/studio/command-line/apkanalyzer?hl=es)</code>: Proporciona estadísticas sobre la composición de tu APK una vez completado el proceso de compilación.
* <code>[avdmanager](https://developer.android.com/studio/command-line/avdmanager?hl=es)</code>: Te permite crear y administrar dispositivos virtuales de Android (AVD) desde la línea de comandos.
* <code>[lint](https://developer.android.com/studio/command-line/lint?hl=es)</code>: Es una herramienta de escaneo de código que te ayuda a identificar y corregir problemas relacionados con la calidad estructural de tu código.
* `screenshot2`: Haz una captura de pantalla del emulador que se esté ejecutando.
* <code>[sdkmanager](https://developer.android.com/studio/command-line/sdkmanager?hl=es)</code>: Te permite ver, instalar, actualizar y desinstalar paquetes para el SDK de Android.
<!-- markdownlint-enable MD033 -->

### Herramientas de compilación del SDK

<!-- markdownlint-disable MD033 -->
* <code>[aapt2](https://developer.android.com/studio/command-line/aapt2?hl=es)</code>: Analiza, indexa y compila recursos de Android en un formato binario que está optimizado para la plataforma Android, y empaqueta los recursos compilados en una sola salida.
* <code>[apksigner](https://developer.android.com/studio/command-line/apksigner?hl=es)</code>: Firma los APK y comprueba si las firmas del APK se verificarán con éxito en todas las versiones de plataforma que admite un APK determinado.
* <code>[zipalign](https://developer.android.com/studio/command-line/zipalign?hl=es)</code>: Optimiza los archivos APK garantizando que todos los datos sin comprimir comiencen con una alineación determinada en relación con el inicio del archivo.
<!-- markdownlint-enable MD033 -->

### Herramientas de plataforma del SDK

<!-- markdownlint-disable MD033 -->
* <code>[adb](https://developer.android.com/studio/command-line/adb?hl=es)</code>: Android Debug Bridge (adb) es una herramienta versátil que te permite administrar el estado de una instancia de emulador o dispositivo con Android. También puedes usarla para instalar un APK en un dispositivo.
* <code>[etc1tool](https://developer.android.com/studio/command-line/etc1tool?hl=es)</code>: Una utilidad de línea de comandos que te permite codificar imágenes PNG al estándar de compresión ETC1 y decodificar imágenes comprimidas ETC1 de nuevo a PNG.
* `fastboot`: Actualiza un dispositivo con imágenes de plataforma y del sistema.
* <code>[logcat](https://developer.android.com/studio/command-line/logcat?hl=es)</code>: Esta es una herramienta que se invoca mediante adb para ver los registros de la app y del sistema.
<!-- markdownlint-enable MD033 -->

### Otras herramientas

<!-- markdownlint-disable MD033 -->
* <code>[ia](https://developer.android.com/topic/google-play-instant/getting-started/instant-enabled-app-bundle?hl=es#build)</code>: Comprueba y ejecuta una aplicación instantánea.
<!-- markdownlint-enable MD033 -->

Además de las anteriores herramientas específicas de Android, también se encuentran disponibles los [comandos de BusyBox](https://busybox.net/downloads/BusyBox.html) y los paquetes instalados en la imagen base:

* `git`
* `unzip`
* `wget`

## Extras

En la imagen base se incluye también el comando `extras` que contiene pequeñas utilidades que no están instaladas por defecto, ya que su uso no está generalizado.

Estos extras se ejecutan mediante el comando `extras <comando>` y son los siguientes:

### Fastlane

[fastlane](https://github.com/fastlane/fastlane) es una herramienta para desarrolladores de iOS y Android para automatizar tareas tediosas como capturas de pantalla, crear perfiles de desarrollador y publicar aplicaciones. Visita su [documentación](https://docs.fastlane.tools/) para más información.

Este comando permite instalar `fastlane`. Hay dos variantes:

```bash
extras fastlane
```

Esta variante permite instalar la última versión de `fastlane`. Si quieres especificar una versión en concreto, el comando es el siguiente:

```bash
extras fastlane 2.166.0
```

## Descargar desde DockerHub

Para descargar una imagen desde DockerHub bastaría con ejecutar el siguiente comando para la versión que se desea descargar:

| API               | Comando                                        |
|-------------------|------------------------------------------------|
| Android 21 (5.0)  | `docker pull alvrme/alpine-android:android-21` |
| Android 22 (5.1)  | `docker pull alvrme/alpine-android:android-22` |
| Android 23 (6.0)  | `docker pull alvrme/alpine-android:android-23` |
| Android 24 (7.0)  | `docker pull alvrme/alpine-android:android-24` |
| Android 25 (7.1)  | `docker pull alvrme/alpine-android:android-25` |
| Android 26 (8.0)  | `docker pull alvrme/alpine-android:android-26` |
| Android 27 (8.1)  | `docker pull alvrme/alpine-android:android-27` |
| Android 28 (9.0)  | `docker pull alvrme/alpine-android:android-28` |
| Android 29 (10.0) | `docker pull alvrme/alpine-android:android-29` |
| Android 30 (11.0) | `docker pull alvrme/alpine-android:android-30` |

## Ejecutar como contenedor

| API               | Comando                                                |
|-------------------|--------------------------------------------------------|
| Android 21 (5.0)  | `docker run --rm -it alvrme/alpine-android:android-21` |
| Android 22 (5.1)  | `docker run --rm -it alvrme/alpine-android:android-22` |
| Android 23 (6.0)  | `docker run --rm -it alvrme/alpine-android:android-23` |
| Android 24 (7.0)  | `docker run --rm -it alvrme/alpine-android:android-24` |
| Android 25 (7.1)  | `docker run --rm -it alvrme/alpine-android:android-25` |
| Android 26 (8.0)  | `docker run --rm -it alvrme/alpine-android:android-26` |
| Android 27 (8.1)  | `docker run --rm -it alvrme/alpine-android:android-27` |
| Android 28 (9.0)  | `docker run --rm -it alvrme/alpine-android:android-28` |
| Android 29 (10.0) | `docker run --rm -it alvrme/alpine-android:android-29` |
| Android 30 (11.0) | `docker run --rm -it alvrme/alpine-android:android-30` |

El comando anterior creará un nuevo contenedor basado en la imagen específica. Se abrirá en el directorio `/home/android` y se podrán ejecutar los diversos [comandos disponibles](#herramientas-incluidas) en el `PATH`. Una vez cerrado el contenedor se eliminará. Para que se mantenga el contenedor después de cerrarlo, hay que quitar `--rm` del comando.

## Contenido de cada imagen

### Imagen base

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |

### Android 21

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;21.1.2          | 21.1.2  | Android SDK Build-Tools             | build-tools/21.1.2/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-21        | 2       | Android SDK Platform 21             | platforms/android-21/        |

### Android 22

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;22.0.1          | 22.0.1  | Android SDK Build-Tools             | build-tools/22.0.1/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-22        | 2       | Android SDK Platform 22             | platforms/android-22/        |

### Android 23

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;23.0.3          | 23.0.3  | Android SDK Build-Tools             | build-tools/23.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-23        | 3       | Android SDK Platform 23             | platforms/android-23/        |

### Android 24

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;24.0.3          | 24.0.3  | Android SDK Build-Tools             | build-tools/24.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-24        | 2       | Android SDK Platform 24             | platforms/android-24/        |

### Android 25

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;25.0.3          | 25.0.3  | Android SDK Build-Tools             | build-tools/25.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-25        | 3       | Android SDK Platform 25             | platforms/android-25/        |

### Android 26

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;26.0.3          | 26.0.3  | Android SDK Build-Tools             | build-tools/26.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-26        | 2       | Android SDK Platform 26             | platforms/android-26/        |

### Android 27

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;27.0.3          | 27.0.3  | Android SDK Build-Tools             | build-tools/27.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-27        | 3       | Android SDK Platform 27             | platforms/android-27/        |

### Android 28

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;28.0.3          | 28.0.3  | Android SDK Build-Tools             | build-tools/28.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-28        | 6       | Android SDK Platform 28             | platforms/android-28/        |

### Android 29

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;29.0.3          | 29.0.3  | Android SDK Build-Tools             | build-tools/29.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-29        | 5       | Android SDK Platform 29             | platforms/android-29/        |

### Android 30

| Paquete                     | Versión | Descripción                         | Ubicación                    |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;30.0.2          | 30.0.2  | Android SDK Build-Tools             | build-tools/30.0.2/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-30        | 3       | Android SDK Platform 30             | platforms/android-30/        |

## Usar en diferentes CI/CD

Aquí hay diferentes configuraciones para algunos de los distintos servicios de CI/CD disponibles. Antes de empezar, hay que recordar de que se debe de usar el _wrapper_ de Gradle y éste necesita permisos de ejecución. Para dar permisos de ejecución a un ejecutable, hay que añadir `chmod +x ./gradlew` a la configuración de los pasos, o usar `git update-index --chmod=+x ./gradlew` en el repositorio y después hacer _push_ del cambio. De esta forma, no será necesario aplicar permisos de ejecución cada vez.

### CircleCI

Un ejemplo de configuración para CircleCI. Para más información, visita la [documentación oficial](https://circleci.com/docs/).

```yaml:.circleci/config.yml
version: 2
jobs:
  build:
    docker:
      - image: alvrme/alpine-android:android-30
    environment:
      JVM_OPTS: -Xmx3200m
    steps:
      - checkout
      - restore_cache:
          key: jars-{{ checksum "build.gradle" }}-{{ checksum  "app/build.gradle" }}
      - run: # Se puede omitir si se ha usado `git update-index --chmod=+x ./gradlew` anteriormente.
         name: Añadir permisos de ejecución
         command: chmod +x ./gradlew
      - run:
          name: Descargar dependencias
          command: ./gradlew androidDependencies
      - save_cache:
          paths:
            - ~/.gradle
          key: jars-{{ checksum "build.gradle" }}-{{ checksum  "app/build.gradle" }}
      - run:
          name: Compilar
          command: ./gradlew build
      - run:
          name: Ejecutar tests
          command: ./gradlew lint test
      - run:
          name: Empaquetar
          command: |
            ./gradlew assembleRelease
            apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<keystore-pass> --key-pass pass:<alias-pass> app.apk # Contraseñas en plano
            apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<keystore-pass> --key-pass env:<alias-pass> app.apk # Contraseñas en variables
```

### GitHub

Un ejemplo de configuración para GitHub Actions. Para más información, visita la [documentación oficial](https://docs.github.com/es/free-pro-team@latest/actions).

```yaml:.github/workflows/android.yml
jobs:
  build:
    container:
      image: alvrme/alpine-android:android-30

    steps:
      - uses: actions/checkout@v2
      - name: Añadir permisos de ejecución # Se puede omitir si se ha usado `git update-index --chmod=+x ./gradlew` anteriormente.
        run: chmod +x ./gradlew
      - uses: actions/cache@v2
        with:
          path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
          key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*') }}
          restore-keys: |
            ${{ runner.os }}-gradle-
      - name: Descargar dependencias
        run: ./gradlew androidDependencies
      - name: Compilar
        run: ./gradlew build
      - name: Ejecutar tests
        run: ./gradlew lint test
      - name: Empaquetar
        run: |
          ./gradlew assembleRelease
          apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<keystore-pass> --key-pass pass:<alias-pass> app.apk # Contraseñas en plano
          apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<keystore-pass> --key-pass env:<alias-pass> app.apk # Contraseñas en variables
```

### GitLab

Un ejemplo de configuración para GitLab CI/CD. Para más información, visita la [documentación oficial](https://docs.gitlab.com/ee/ci/).

```yaml:.gitlab-ci.yml
image: alvrme/alpine-android:android-30

before_script:
  - export GRADLE_USER_HOME=`pwd`/.gradle
  - chmod +x ./gradlew # Se puede omitir si se ha usado `git update-index --chmod=+x ./gradlew` anteriormente.

cache:
  key: "$CI_COMMIT_REF_NAME" # Opcional: compartir caché por ramas
  paths:
     - .gradle/wrapper
     - .gradle/caches

stages:
  - build
  - test
  - assemble

build:
  stage: build
  script:
    - ./gradlew build

tests:
  stage: test
  script:
    - ./gradlew lint test

assemble:
  stage: assemble
  script:
    - ./gradlew assembleRelease
    - apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<keystore-pass> --key-pass pass:<alias-pass> app.apk # Contraseñas en plano
    - apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<keystore-pass> --key-pass env:<alias-pass> app.apk # Contraseñas en variables
```

## Estadísticas

[![dockeri.co](https://dockeri.co/image/alvrme/alpine-android-base)](https://hub.docker.com/r/alvrme/alpine-android-base)
[![dockeri.co](https://dockeri.co/image/alvrme/alpine-android)](https://hub.docker.com/r/alvrme/alpine-android)

## Enlaces

{{< button href="https://github.com/alvr/alpine-android" color="primary" >}}**GitHub**{{</ button >}}

{{< button href="https://hub.docker.com/r/alvrme/alpine-android" color="primary" >}}**Docker Alpine Android**{{</ button >}}
{{< button href="https://hub.docker.com/r/alvrme/alpine-android-base" color="primary" >}}**Docker Alpine Android Base**{{</ button >}}
