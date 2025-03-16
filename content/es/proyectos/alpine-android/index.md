---
title: Alpine Android
summary: Entorno Docker minimalista optimizado para construir y probar aplicaciones Android.

date: 2017-03-29T22:44:48+02:00
lastmod: 2025-03-13T19:46:00+02:00

categories: 
  - Android
  - Docker
tags: 
  - alpine
  - despliegue continuo
  - integración continua
  - docker
  - docker container

menu:
  main:
    identifier: alpine-android
    parent: projects
    name: Alpine Android
    title: Alpine Android
    weight: 1

slug: alpine-android
translationKey: alpine-android
---

<p align="center">
  <img alt="Alpine Android" src="docker-android.webp"/>
</p>

<p align="center">
  <a href="https://github.com/alvr/alpine-android/actions/workflows/default.yaml"><img alt="Estado de compilación de GitHub" src="https://img.shields.io/github/actions/workflow/status/alvr/alpine-android/default.yaml?logo=github"/></a>
  <a href="https://github.com/alvr/alpine-android/releases/latest"><img alt="Última versión" src="https://img.shields.io/github/v/release/alvr/alpine-android?logo=android&logoColor=white&color=066da5"/></a>
  <a href="https://newreleases.io/dockerhub/alvrme/alpine-android"><img alt="Notificar nuevas versiones" src="https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-recibir%20notificaciones-%23005cc5"/></a>
</p>

<p align="center">
  <img alt="Descargas de Docker Alpine Android Base" src="https://img.shields.io/docker/pulls/alvrme/alpine-android-base?label=descargas%20base&logo=docker&logoColor=white&color=066da5"/>
  <img alt="Descargas de Docker Alpine Android Main" src="https://img.shields.io/docker/pulls/alvrme/alpine-android?label=descargas%20main&logo=docker&logoColor=white&color=066da5"/>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/alvrme/alpine-android-base"><img alt="Enlace DockerHub" src="https://img.shields.io/badge/imagen%20base-hub-%23066da5?logo=docker&logoColor=white"/></a>
  <a href="https://github.com/users/alvr/packages/container/package/alpine-android-base"><img alt="Enlace GitHub Container Registry" src="https://img.shields.io/badge/imagen%20base-ghcr-black?logo=github&logoColor=white"/></a>
  <a href="https://quay.io/repository/alvr/alpine-android-base"><img alt="Enlace Quay" src="https://img.shields.io/badge/imagen%20base-quay-%23D71E00?logo=redhat&logoColor=white"/></a>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/alvrme/alpine-android"><img alt="Enlace DockerHub" src="https://img.shields.io/badge/imagen%20principal-hub-%23066da5?logo=docker&logoColor=white"/></a>
  <a href="https://github.com/users/alvr/packages/container/package/alpine-android"><img alt="Enlace GitHub Container Registry" src="https://img.shields.io/badge/imagen%20principal-ghcr-black?logo=github&logoColor=white"/></a>
  <a href="https://quay.io/repository/alvr/alpine-android"><img alt="Enlace Quay" src="https://img.shields.io/badge/imagen%20principal-quay-%23D71E00?logo=redhat&logoColor=white"/></a>
</p>

{{< link "https://github.com/alvr/alpine-android" "Alpine Android" "Repositorio de GitHub de Alpine Android" true "fa-brands fa-github" >}}

## Descripción

Alpine Android es una imagen Docker ligera para compilar y probar aplicaciones Android. Basada en la imagen de Alpine, hace que el tamaño sea más pequeño en comparación con las imágenes basadas en Debian o Ubuntu. Además, hay diferentes imágenes por SDK y solo se incluyen los paquetes mínimos.

Están disponibles las versiones del SDK desde Android 28 hasta Android 36. Cada versión del SDK tiene su propia imagen, siendo el identificador `alvrme/alpine-android:android-<versión>`. Si siempre quieres referirte a la última versión estable de Android disponible, también puedes usar `alvrme/alpine-android:latest`.

## Alpine Android Base

La imagen en la que se basan las imágenes específicas del SDK de Android. Esto facilita la actualización de las imágenes que se extienden a partir de ella, ya que solo habría que modificar el `Dockerfile` necesario.

### Usar como imagen base

Para extender la imagen base y poder configurar tu propia imagen con los paquetes y aplicaciones que desees, simplemente añade la siguiente línea en la parte superior del `Dockerfile`:

```dockerfile
FROM alvrme/alpine-android-base
```

### Instalar aplicaciones y paquetes

Puedes instalar cualquier aplicación de Alpine de la [siguiente lista](https://pkgs.alpinelinux.org/packages?name=&branch=v3.21&arch=x86_64) añadiendo el siguiente comando al `Dockerfile`:

```dockerfile
RUN apk add --no-cache <paquete1> <paquete2> <...> && \
    rm -rf /tmp/* /var/tmp/*
```

De manera similar, puedes instalar cualquier [paquete disponible](https://gist.github.com/alvr/8db356880447d2c4bbe948ea92d22c23) de Android:

```dockerfile
RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install <paquete1> <paquete2> <...>
```

## Variantes

Hay tres variantes de la imagen, todas basadas en `bellsoft/liberica-openjdk-alpine`:

* Las imágenes JDK8 se basan en Liberica JDK 8u422-7 y usan el sufijo `-jdk8` en la etiqueta.
* Las imágenes JDK11 se basan en Liberica JDK 11.0.26-9 y usan el sufijo `-jdk11` en la etiqueta.
* Las imágenes JDK17 se basan en Liberica JDK 17.0.14-10 y usan el sufijo `-jdk17` en la etiqueta.
* Las imágenes JDK21 se basan en Liberica JDK 21.0.6+10 y usan el sufijo `-jdk21` en la etiqueta.

### ¿Cuál debería usar?

| Versión JDK | Versión AGP         |
|-------------|---------------------|
| 8           | < 7.0.0             |
| 11          | >= 7.0.0 && < 8.0.0 |
| 17          | >= 8.0.0            |
| 21          | >= 8.2.1            |

Esto facilita la actualización de las imágenes que se extienden a partir de ella, ya que solo habría que modificar el `Dockerfile` necesario.

## Etiquetado

| Nivel API        | JDK8                             | JDK11                                            | JDK17                                        | JDK21                              |
|------------------|----------------------------------|--------------------------------------------------|----------------------------------------------|------------------------------------|
| Imagen Base      | `jdk8` `latest-jdk8`             | `jdk11`, `latest-jdk11`                          | `jdk17`, `latest`, `latest-jdk17`            | `jdk21`, `latest-jdk21`            |
| Android 9.0 (28) | `android-28-jdk8`                | `android-28`, `android-28-jdk11`                 | `android-28-jdk17`                           | `android-28-jdk21`                 |
| Android 10 (29)  | `android-29-jdk8`                | `android-29`, `android-29-jdk11`                 | `android-29-jdk17`                           | `android-29-jdk21`                 |
| Android 11 (30)  | `android-30-jdk8`                | `android-30`, `android-30-jdk11`                 | `android-30-jdk17`                           | `android-30-jdk21`                 |
| Android 12 (31)  | `android-31-jdk8`                | `android-31`, `android-31-jdk11`                 | `android-31-jdk17`                           | `android-31-jdk21`                 |
| Android 12L (32) | `android-32-jdk8`                | `android-32`, `android-32-jdk11`                 | `android-32-jdk17`                           | `android-32-jdk21`                 |
| Android 13 (33)  | `android-33-jdk8`                | `android-33`, `android-33-jdk11`                 | `android-33-jdk17`                           | `android-33-jdk21`                 |
| Android 14 (34)  | `android-34-jdk8`                | `android-34`, `android-34-jdk11`                 | `android-34-jdk17`                           | `android-34-jdk21`                 |
| Android 15 (35)  | `android-35-jdk8`, `latest-jdk8` | `android-35`, `android-35-jdk11`, `latest-jdk11` | `android-35-jdk17`, `latest`, `latest-jdk17` | `android-35-jdk21`, `latest-jdk21` |
| Android 16 (36)  | `android-36-jdk8`                | `android-36`, `android-36-jdk11`                 | `android-36-jdk17`                           | `android-36-jdk21`                 |

### Versionado

Desde el 1 de enero de 2021, las nuevas versiones ahora incluyen la fecha en que se publicaron, por lo que es posible revertir a una versión anterior. El versionado solo se aplica a las etiquetas con la versión de JDK especificada. El formato de la etiqueta es: `android-XX-jdkZZ-vYYYY.MM.DD`, donde:

* `XX` es el nivel de API.
* `ZZ` es la versión del JDK.
* `YYYY` es el año de la versión de lanzamiento.
* `MM` es el mes del año de la versión de lanzamiento con ceros a la izquierda.
* `DD` es el día del mes de la versión de lanzamiento con ceros a la izquierda.

Un ejemplo válido sería `android-30-jdk11-v2021.01.01`. [Aquí](https://github.com/alvr/alpine-android/releases) están listadas todas las versiones.

> :memo: El versionado no está disponible para `alpine-android-base`.

## Herramientas incluidas

A continuación se muestra una lista de todas las herramientas incluidas con la instalación de los diferentes paquetes. Aquellas que tienen su propia documentación están enlazadas.

{{< admonition info "Gradle" >}}
El paquete `gradle` no está instalado, por lo que el comando en el `PATH` no está disponible. La razón de esto es que el paquete puede estar desactualizado y no ser compatible con ninguna de las APIs utilizadas en la configuración. Por eso siempre debes usar el _wrapper_ que viene con el proyecto y cuya versión se indica en el archivo `gradle-wrapper.properties`. Puedes consultar [aquí](#uso-en-diferentes-cicd) cómo configurar el _wrapper_ para usarlo en los diferentes servicios de CI/CD.
{{< /admonition >}}

### Línea de comandos

* <code>[apkanalyzer](https://developer.android.com/studio/command-line/apkanalyzer?hl=es)</code>: Proporciona información sobre la composición de tu APK después de que se complete el proceso de compilación.
* <code>[avdmanager](https://developer.android.com/studio/command-line/avdmanager?hl=es)</code>: Te permite crear y gestionar Dispositivos Virtuales Android (AVDs) desde la línea de comandos.
* <code>[lint](https://developer.android.com/studio/command-line/lint?hl=es)</code>: Una herramienta de escaneo de código que puede ayudarte a identificar y corregir problemas con la calidad estructural de tu código.
* `screenshot2`: Hace una captura de pantalla del emulador en ejecución.
* <code>[sdkmanager](https://developer.android.com/studio/command-line/sdkmanager?hl=es)</code>: Te permite ver, instalar, actualizar y desinstalar paquetes para el SDK de Android.

### Compilación del SDK

* <code>[aapt2](https://developer.android.com/studio/command-line/aapt2?hl=es)</code>: Analiza, indexa y compila recursos de Android en un formato binario optimizado para la plataforma Android, y empaqueta los recursos compilados en una sola salida.
* <code>[apksigner](https://developer.android.com/studio/command-line/apksigner?hl=es)</code>: Firma APKs y comprueba si las firmas de APK se verificarán correctamente en todas las versiones de la plataforma que soporta un APK dado.
* <code>[zipalign](https://developer.android.com/studio/command-line/zipalign?hl=es)</code>: Optimiza archivos APK asegurando que todos los datos no comprimidos comiencen con una alineación particular relativa al inicio del archivo.

### Plataforma SDK

* <code>[adb](https://developer.android.com/studio/command-line/adb?hl=es)</code>: Android Debug Bridge (adb) es una herramienta versátil que te permite gestionar el estado de una instancia de emulador o dispositivo Android. También puedes usarlo para instalar un APK en un dispositivo.
* <code>[etc1tool](https://developer.android.com/studio/command-line/etc1tool?hl=es)</code>: Una utilidad de línea de comandos que te permite codificar imágenes PNG al estándar de compresión ETC1 y decodificar imágenes comprimidas ETC1 de vuelta a PNG.
* `fastboot`: Flashea un dispositivo con imágenes de plataforma y otras imágenes del sistema.
* <code>[logcat](https://developer.android.com/studio/command-line/logcat?hl=es)</code>: Esta es una herramienta invocada a través de adb para ver registros de aplicaciones y del sistema.

### Otras herramientas

* <code>[ia](https://developer.android.com/topic/google-play-instant/getting-started/instant-enabled-app-bundle?hl=es#build)</code>: Comprueba y ejecuta una aplicación instantánea.

Además de las herramientas específicas de Android mencionadas anteriormente, también están disponibles los [comandos de BusyBox](https://busybox.net/downloads/BusyBox.html) y los paquetes instalados en la imagen base:

* `git`
* `unzip`
* `wget`

### Extras

La imagen base también incluye el comando `extras` que contiene pequeñas utilidades que no están instaladas por defecto, ya que su uso no está muy extendido. Estos extras se ejecutan con el comando `extras <comando>` y son los siguientes:

#### Fastlane

[fastlane](https://github.com/fastlane/fastlane) es una herramienta para desarrolladores de iOS y Android para automatizar tareas tediosas como generar capturas de pantalla, manejar perfiles de aprovisionamiento y lanzar tu aplicación. Visita su [documentación](https://docs.fastlane.tools/) para más información.

Este comando te permite instalar `fastlane`. Hay dos variantes:

```bash
extras fastlane
```

Este comando te permite instalar la última versión de `fastlane`. Si quieres usar una versión específica, el comando es el siguiente:

```bash
extras fastlane [VERSION]
```

#### NDK & CMake

[NDK](https://developer.android.com/ndk) (Native Development Kit) es un conjunto de herramientas que permite a los desarrolladores implementar partes de aplicaciones Android utilizando lenguajes de código nativo como C y C++.  
[CMake](https://developer.android.com/ndk/guides/cmake) es un generador de sistemas de compilación multiplataforma que ayuda a gestionar el proceso de compilación de software de forma independiente del compilador.

Para instalar NDK y/o CMake, ejecuta el siguiente comando:

```bash
extras ndk [--ndk | -n NDK_VERSION] [--cmake | -c CMAKE_VERSION]
```

## Contenido de cada imagen

{{< details "Ver contenido de la imagen Android Base" >}}

![Tamaño Docker Android Base JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android Base JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android Base JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android Base JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 9 (Pie)" >}}

![Tamaño Docker Android 9 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 9 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 9 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 9 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;28.0.3        | 28.0.3  | Android SDK Build-Tools             | build-tools/28.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-28      | 6       | Android SDK Platform 28             | platforms/android-28/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 10 (Q)" >}}

![Tamaño Docker Android 10 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 10 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 10 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 10 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;29.0.3        | 29.0.3  | Android SDK Build-Tools             | build-tools/29.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-29      | 5       | Android SDK Platform 29             | platforms/android-29/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 11 (R)" >}}

![Tamaño Docker Android 11 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 11 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 11 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 11 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;30.0.3        | 30.0.3  | Android SDK Build-Tools             | build-tools/30.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-30      | 3       | Android SDK Platform 30             | platforms/android-30/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 12 (S)" >}}

![Tamaño Docker Android 12 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 12 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 12 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 12 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;31.0.0        | 31.0.0  | Android SDK Build-Tools             | build-tools/31.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-31      | 1       | Android SDK Platform 31             | platforms/android-31/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 12L" >}}

![Tamaño Docker Android 12L JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 12L JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 12L JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 12L JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;32.0.0        | 32.0.0  | Android SDK Build-Tools             | build-tools/32.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-32      | 1       | Android SDK Platform 32             | platforms/android-32/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 13 (Tiramisu)" >}}

![Tamaño Docker Android 13 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 13 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 13 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 13 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;33.0.2        | 33.0.3  | Android SDK Build-Tools             | build-tools/33.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-33      | 2       | Android SDK Platform 33             | platforms/android-33/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 14 (Upside-down Cake)" >}}

![Tamaño Docker Android 14 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 14 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 14 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 14 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;34.0.0        | 34.0.0  | Android SDK Build-Tools             | build-tools/34.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-34      | 3       | Android SDK Platform 34             | platforms/android-34/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 15 (VanillaIceCream)" >}}

![Tamaño Docker Android 15 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 15 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 15 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 15 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;35.0.1        | 35.0.1  | Android SDK Build-Tools             | build-tools/35.0.1/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-35      | 2       | Android SDK Platform 35             | platforms/android-35/      |

{{< /details >}}

{{< details "Ver contenido de la imagen Android 16 (Baklava)" >}}

![Tamaño Docker Android 16 JDK8](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk8?label=tamaño%20imagen%20jdk8) ![Tamaño Docker Android 16 JDK11](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk11?label=tamaño%20imagen%20jdk11) ![Tamaño Docker Android 16 JDK17](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk17?label=tamaño%20imagen%20jdk17) ![Tamaño Docker Android 16 JDK21](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk21?label=tamaño%20imagen%20jdk21)

| Ruta                      | Versión | Descripción                         | Ubicación                  |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;36.0.0        | 36.0.0  | Android SDK Build-Tools             | build-tools/36.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 36.0.0  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-36      | 1       | Android SDK Platform 36             | platforms/android-36/      |

{{< /details >}}

## Registros de contenedores

Debido a los [límites de tasa de DockerHub](https://www.docker.com/increase-rate-limits), la imagen ahora está en tres registros de contenedores diferentes:

* DockerHub: [Imagen Base](https://hub.docker.com/r/alvrme/alpine-android-base/tags) e [Imagen Android](https://hub.docker.com/r/alvrme/alpine-android/tags).
* GitHub Container Registry: [Imagen Base](https://github.com/users/alvr/packages/container/alpine-android-base/versions) e [Imagen Android](https://github.com/users/alvr/packages/container/alpine-android/versions).
* Quay: [Imagen Base](https://quay.io/repository/alvr/alpine-android-base?tab=tags) e [Imagen Android](https://quay.io/repository/alvr/alpine-android?tab=tags).

### Como imagen base

Reemplaza `<etiqueta>` con una de las [etiquetas disponibles](#etiquetado) actuales.

#### Imagen base de DockerHub

Puedes usar las imágenes Docker de DockerHub como base para crear una nueva:

```Dockerfile
FROM alvrme/alpine-android-base:<etiqueta>
```

```Dockerfile
FROM alvrme/alpine-android:<etiqueta>
```

#### Imagen base de GHCR

Puedes usar las imágenes Docker de GitHub Container Registry como base para crear una nueva:

```Dockerfile
FROM ghcr.io/alvr/alpine-android-base:<etiqueta>
```

```Dockerfile
FROM ghcr.io/alvr/alpine-android:<etiqueta>
```

#### Imagen base de Quay

Puedes usar las imágenes Docker de Quay como base para crear una nueva:

```Dockerfile
FROM quay.io/alvr/alpine-android-base:<etiqueta>
```

```Dockerfile
FROM quay.io/alvr/alpine-android:<etiqueta>
```

### Descarga

Reemplaza `<etiqueta>` con una de las [etiquetas disponibles](#etiquetado) actuales.

#### Descarga de DockerHub

Puedes descargar una imagen Docker específica de DockerHub con el siguiente comando:

```bash
docker pull alvrme/alpine-android-base:<etiqueta>
```

```bash
docker pull alvrme/alpine-android:<etiqueta>
```

#### Descarga de GHCR

Puedes descargar una imagen Docker específica de GitHub Container Registry con el siguiente comando:

```bash
docker pull ghcr.io/alvr/alpine-android-base:<etiqueta>
```

```bash
docker pull ghcr.io/alvr/alpine-android:<etiqueta>
```

#### Descarga de Quay

Puedes descargar una imagen Docker específica de Quay con el siguiente comando:

```bash
docker pull quay.io/alvr/alpine-android-base:<etiqueta>
```

```bash
docker pull quay.io/alvr/alpine-android:<etiqueta>
```

### Ejecutar contenedor

Reemplaza `<etiqueta>` con una de las [etiquetas disponibles](#etiquetado) actuales.

El siguiente comando creará un nuevo contenedor basado en la imagen específica. Se abrirá en el directorio `/home/android` y los diversos [comandos disponibles](#herramientas-incluidas) en el `PATH` podrán ser ejecutados. Una vez que se cierre el contenedor, será eliminado. Para mantener el contenedor después de cerrarlo, debes eliminar `--rm` del comando.

#### Ejecutar contenedor de DockerHub

Ejecuta el contenedor desde la imagen de DockerHub:

```bash
docker run --rm -it alvrme/alpine-android-base:<etiqueta>
```

```bash
docker run --rm -it alvrme/alpine-android:<etiqueta>
```

#### Ejecutar contenedor de GHCR

Ejecuta el contenedor desde la imagen de GitHub Container Registry:

```bash
docker run --rm -it ghcr.io/alvr/alpine-android-base:<etiqueta>
```

```bash
docker run --rm -it ghcr.io/alvr/alpine-android:<etiqueta>
```

#### Ejecutar contenedor de Quay

Ejecuta el contenedor desde la imagen de Quay:

```bash
docker run --rm -it quay.io/alvr/alpine-android-base:<etiqueta>
```

```bash
docker run --rm -it quay.io/alvr/alpine-android:<etiqueta>
```

## Uso en diferentes CI/CD

Aquí hay diferentes configuraciones para algunos de los servicios de CI/CD disponibles. Antes de comenzar, recuerda que debes usar el _wrapper_ de Gradle y necesita permisos de ejecución. Para dar permisos de ejecución a un ejecutable, agrega `chmod +x ./gradlew` a los pasos, o usa `git update-index --chmod=+x ./gradlew` en el repositorio y luego haz _push_ de los cambios. De esta manera, no tienes que dar permisos cada vez.

### CircleCI

Un ejemplo de configuración de CircleCI. Para más información, visita la [documentación oficial](https://circleci.com/docs/).

```yaml:.circleci/config.yml
version: 2
jobs:
  build:
    docker:
      - image: alvrme/alpine-android:android-<version>
    environment:
      JVM_OPTS: -Xmx3200m
    steps:
      - checkout
      - restore_cache:
          key: jars-{{ checksum "build.gradle" }}-{{ checksum  "app/build.gradle" }}
      - run: # Se puede omitir si se usó git update-index --chmod=+x ./gradlew antes.
         name: Chmod
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
          name: Ensamblar
          command: |
            ./gradlew assembleRelease
            apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<contraseña-keystore> --key-pass pass:<contraseña-alias> app.apk # Contraseñas en texto plano
            apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<contraseña-keystore> --key-pass env:<contraseña-alias> app.apk # Contraseñas en variables de entorno
```

### GitHub

Un ejemplo de configuración de GitHub Actions. Para más información, visita la [documentación oficial](https://docs.github.com/es/actions).

```yaml:.github/workflows/android.yml
jobs:
  build:
    container:
      image: alvrme/alpine-android:android-<version>

    steps:
      - uses: actions/checkout@v2
      - name: Chmod # Se puede omitir si se usó git update-index --chmod=+x ./gradlew antes.
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
      - name: Ensamblar
        run: |
          ./gradlew assembleRelease
          apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<contraseña-keystore> --key-pass pass:<contraseña-alias> app.apk # Contraseñas en texto plano
          apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<contraseña-keystore> --key-pass env:<contraseña-alias> app.apk # Contraseñas en variables de entorno
```

### GitLab

Un ejemplo de configuración de GitLab CI/CD. Para más información, visita la [documentación oficial](https://docs.gitlab.com/ee/ci/).

```yaml:.gitlab-ci.yml
image: alvrme/alpine-android:android-<version>

before_script:
  - export GRADLE_USER_HOME=`pwd`/.gradle
  - chmod +x ./gradlew # Se puede omitir si se usó git update-index --chmod=+x ./gradlew antes.

cache:
  key: "$CI_COMMIT_REF_NAME" # Opcional: compartir caché entre ramas
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
    - apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<contraseña-keystore> --key-pass pass:<contraseña-alias> app.apk # Contraseñas en texto plano
    - apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<contraseña-keystore> --key-pass env:<contraseña-alias> app.apk # Contraseñas en variables de entorno
```
