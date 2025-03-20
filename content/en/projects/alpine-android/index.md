---
title: Alpine Android
summary: Minimalist Docker environment optimized for building and testing Android applications.

date: 2017-03-29T22:44:48+02:00
lastmod: 2025-03-13T19:46:00+02:00

categories: 
  - Android
  - Docker
tags: 
  - alpine
  - continuous deployment
  - continuous integration
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
  <a href="https://github.com/alvr/alpine-android/actions/workflows/default.yaml"><img alt="GitHub build status" src="https://img.shields.io/github/actions/workflow/status/alvr/alpine-android/default.yaml?logo=github"/></a>
  <a href="https://github.com/alvr/alpine-android/releases/latest"><img alt="Latest release" src="https://img.shields.io/github/v/release/alvr/alpine-android?logo=android&logoColor=white&color=066da5"/></a>
  <a href="https://newreleases.io/dockerhub/alvrme/alpine-android"><img alt="Notify new versions" src="https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-get%20notified-%23005cc5"/></a>
</p>

<p align="center">
  <img alt="Docker Alpine Android Base Pulls" src="https://img.shields.io/docker/pulls/alvrme/alpine-android-base?label=base%20pulls&logo=docker&logoColor=white&color=066da5"/>
  <img alt="Docker Alpine Android Main Pulls" src="https://img.shields.io/docker/pulls/alvrme/alpine-android?label=main%20pulls&logo=docker&logoColor=white&color=066da5"/>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/alvrme/alpine-android-base"><img alt="DockerHub Link" src="https://img.shields.io/badge/base%20image-hub-%23066da5?logo=docker&logoColor=white"/></a>
  <a href="https://github.com/users/alvr/packages/container/package/alpine-android-base"><img alt="GitHub Container Registry Link" src="https://img.shields.io/badge/base%20image-ghcr-black?logo=github&logoColor=white"/></a>
  <a href="https://quay.io/repository/alvr/alpine-android-base"><img alt="Quay Link" src="https://img.shields.io/badge/base%20image-quay-%23D71E00?logo=redhat&logoColor=white"/></a>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/alvrme/alpine-android"><img alt="DockerHub Link" src="https://img.shields.io/badge/main%20image-hub-%23066da5?logo=docker&logoColor=white"/></a>
  <a href="https://github.com/users/alvr/packages/container/package/alpine-android"><img alt="GitHub Container Registry Link" src="https://img.shields.io/badge/main%20image-ghcr-black?logo=github&logoColor=white"/></a>
  <a href="https://quay.io/repository/alvr/alpine-android"><img alt="Quay Link" src="https://img.shields.io/badge/main%20image-quay-%23D71E00?logo=redhat&logoColor=white"/></a>
</p>

{{< link "https://github.com/alvr/alpine-android" "Alpine Android" "GitHub repository of Alpine Android" true "fa-brands fa-github" >}}

## Description

Alpine Android is a lightweight Docker image for compiling and testing Android applications. Based on Alpine's image, it makes the size smaller compared to Debian or Ubuntu based images. Also, there are different images per SDK and only the minimum packages are included.

SDK versions from Android 28 to Android 36 are available. Each version of the SDK has its own image, being the identifier `alvrme/alpine-android:android-<version>`. If you always want to refer to the latest stable Android version available, you can also use `alvrme/alpine-android:latest`.

## Alpine Android Base

The image the specific Android SDK's images are based on. This makes it easy to update the images that extend from it, since only the necessary `Dockerfile` would have to be modified.

### Use as base image

To extend the base image and be able to configure your own image with the packages and applications you want, just add the following line to the top of `Dockerfile`:

```dockerfile
FROM alvrme/alpine-android-base
```

### Install applications and packages

You can install any Alpine application from the [following list](https://pkgs.alpinelinux.org/packages?name=&branch=v3.21&arch=x86_64) by adding the following command to the `Dockerfile

```dockerfile
RUN apk add --no-cache <package1> <package2> <...> && \
    rm -rf /tmp/* /var/tmp/*
```

Similarly, you can install any [available package](https://gist.github.com/alvr/8db356880447d2c4bbe948ea92d22c23) of Android:

```dockerfile
RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install <package1> <package2> <...>
```

## Variants

There are three variants of the image, all based on `bellsoft/liberica-openjdk-alpine`:

* JDK8 images are based on Liberica JDK 8u422-7 and uses the tag's suffix `-jdk8`.
* JDK11 images are based on Liberica JDK 11.0.26-9 and uses the tag's suffix `-jdk11`.
* JDK17 images are based on Liberica JDK 17.0.14-10 and uses the tag's suffix `-jdk17`.
* JDK21 images are based on Liberica JDK 21.0.6+10 and uses the tag's suffix `-jdk21`.

### Which one should I use?

| JDK version | AGP version         |
|-------------|---------------------|
| 8           | < 7.0.0             |
| 11          | >= 7.0.0 && < 8.0.0 |
| 17          | >= 8.0.0            |
| 21          | >= 8.2.1            |

This makes it easy to update the images that extend from it, since only the necessary `Dockerfile` would have to be modified.

## Tagging

| API level        | JDK8                             | JDK11                                            | JDK17                                        | JDK21                              |
|------------------|----------------------------------|--------------------------------------------------|----------------------------------------------|------------------------------------|
| Base Image       | `jdk8` `latest-jdk8`             | `jdk11`, `latest-jdk11`                          | `jdk17`, `latest`, `latest-jdk17`            | `jdk21`, `latest-jdk21`            |
| Android 9.0 (28) | `android-28-jdk8`                | `android-28`, `android-28-jdk11`                 | `android-28-jdk17`                           | `android-28-jdk21`                 |
| Android 10 (29)  | `android-29-jdk8`                | `android-29`, `android-29-jdk11`                 | `android-29-jdk17`                           | `android-29-jdk21`                 |
| Android 11 (30)  | `android-30-jdk8`                | `android-30`, `android-30-jdk11`                 | `android-30-jdk17`                           | `android-30-jdk21`                 |
| Android 12 (31)  | `android-31-jdk8`                | `android-31`, `android-31-jdk11`                 | `android-31-jdk17`                           | `android-31-jdk21`                 |
| Android 12L (32) | `android-32-jdk8`                | `android-32`, `android-32-jdk11`                 | `android-32-jdk17`                           | `android-32-jdk21`                 |
| Android 13 (33)  | `android-33-jdk8`                | `android-33`, `android-33-jdk11`                 | `android-33-jdk17`                           | `android-33-jdk21`                 |
| Android 14 (34)  | `android-34-jdk8`                | `android-34`, `android-34-jdk11`                 | `android-34-jdk17`                           | `android-34-jdk21`                 |
| Android 15 (35)  | `android-35-jdk8`, `latest-jdk8` | `android-35`, `android-35-jdk11`, `latest-jdk11` | `android-35-jdk17`, `latest`, `latest-jdk17` | `android-35-jdk21`, `latest-jdk21` |
| Android 16 (36)  | `android-36-jdk8`                | `android-36`, `android-36-jdk11`                 | `android-36-jdk17`                           | `android-36-jdk21`                 |

### Versioning

Since January 1st 2021, new versions now include the date it was published so is possible to revert to a previous version. The versioning only applies to tags with the JDK version specified. The tag's format is: `android-XX-jdkZZ-vYYYY.MM.DD`, where:

* `XX` is the API level.
* `ZZ` is the version of the JDK.
* `YYYY` is the year of the release version.
* `MM` is the month of the year of the release version with leading zeros.
* `DD` is the day of the month of the release version with leading zeros.

A valid example would be `android-30-jdk11-v2021.01.01`. [Here](https://github.com/alvr/alpine-android/releases) are listed all the versions.

> :memo: The versioning is not available for `alpine-android-base`.

## Tools included

Below is a list of all the tools included with the installation of the different packages. Those with their own documentation are linked.

{{< admonition info "Gradle" >}}
The `gradle` package is not installed, so the command in the `PATH` is not available. The reason for this is that the package may be outdated and not compatible with any of the APIs used in the configuration. That's why you should always use the _wrapper_ that comes with the project and whose version is indicated in the `gradle-wrapper.properties` file. You can consult [here](#use-in-different-cicd) how to configure the _wrapper_ to use it in the different CI/CD services.
{{< /admonition >}}

### Command-line

* <code>[apkanalyzer](https://developer.android.com/studio/command-line/apkanalyzer?hl=en)</code>: Provides insight into the composition of your APK after the build process completes.
* <code>[avdmanager](https://developer.android.com/studio/command-line/avdmanager?hl=en)</code>: Allows you to create and manage Android Virtual Devices (AVDs) from the command line.
* <code>[lint](https://developer.android.com/studio/command-line/lint?hl=en)</code>: A code scanning tool that can help you to identify and correct problems with the structural quality of your code.
* `screenshot2`: Do a screenshot of the running emulator.
* <code>[sdkmanager](https://developer.android.com/studio/command-line/sdkmanager?hl=en)</code>: Allows you to view, install, update, and uninstall packages for the Android SDK.

### SDK build

* <code>[aapt2](https://developer.android.com/studio/command-line/aapt2?hl=en)</code>: Parses, indexes, and compiles Android resources into a binary format that is optimized for the Android platform, and packages the compiled resources into a single output.
* <code>[apksigner](https://developer.android.com/studio/command-line/apksigner?hl=en)</code>: Signs APKs and checks whether APK signatures will be verified successfully on all platform versions that a given APK supports.
* <code>[zipalign](https://developer.android.com/studio/command-line/zipalign?hl=en)</code>: Optimizes APK files by ensuring that all uncompressed data starts with a particular alignment relative to the start of the file.

### SDK platform

* <code>[adb](https://developer.android.com/studio/command-line/adb?hl=en)</code>: Android Debug Bridge (adb) is a versatile tool that lets you manage the state of an emulator instance or Android-powered device. You can also use it to install an APK on a device.
* <code>[etc1tool](https://developer.android.com/studio/command-line/etc1tool?hl=en)</code>: A command line utility that lets you encode PNG images to the ETC1 compression standard and decode ETC1 compressed images back to PNG.
* `fastboot`: Flashes a device with platform and other system images.
* <code>[logcat](https://developer.android.com/studio/command-line/logcat?hl=en)</code>: This is a tool invoked via adb to view app and system logs.

### Other tools

* <code>[ia](https://developer.android.com/topic/google-play-instant/getting-started/instant-enabled-app-bundle?hl=en#build)</code>: Check and run an instant application.

In addition to the above Android-specific tools, the [BusyBox commands](https://busybox.net/downloads/BusyBox.html) and packages installed on the base image are also available:

* `git`
* `unzip`
* `wget`

### Extras

The base image also includes the `extras` command that contains small utilities that are not installed by default, since their use is not widespread. These extras are executed with the command `extras <command>` and are the following:

#### Fastlane

[fastlane](https://github.com/fastlane/fastlane) is a tool for iOS and Android developers to automate tedious tasks like generating screenshots, dealing with provisioning profiles, and releasing your application. Visit their [documentation](https://docs.fastlane.tools/) for more information.

This command allows you to install `fastlane`. There are two variants:

```bash
extras fastlane
```

This command allows you to install the latest version of `fastlane`. If you want to use a specific version, the command is as follows:

```bash
extras fastlane [VERSION]
```

#### NDK & CMake

[NDK](https://developer.android.com/ndk) (Native Development Kit) is a toolset that allows developers to implement parts of Android applications using native-code languages such as C and C++.  
[CMake](https://developer.android.com/ndk/guides/cmake) is a cross-platform build system generator that helps manage the software build process in a compiler-independent way.

To install NDK and/or CMake, execute the following command:

```bash
extras ndk [--ndk | -n NDK_VERSION] [--cmake | -c CMAKE_VERSION]
```

## Content of each image

{{< details "See content of Android Base image" >}}

![Docker Android Base JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk8?label=jdk8%20image%20size) ![Docker Android Base JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk11?label=jdk11%20image%20size) ![Docker Android Base JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk17?label=jdk17%20image%20size) ![Docker Android Base JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android-base/jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |

{{< /details >}}

{{< details "See content of Android 9 (Pie) image" >}}

![Docker Android 9 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk8?label=jdk8%20image%20size) ![Docker Android 9 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk11?label=jdk11%20image%20size) ![Docker Android 9 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk17?label=jdk17%20image%20size) ![Docker Android 9 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-28-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;28.0.3        | 28.0.3  | Android SDK Build-Tools             | build-tools/28.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-28      | 6       | Android SDK Platform 28             | platforms/android-28/      |

{{< /details >}}

{{< details "See content of Android 10 (Q) image" >}}

![Docker Android 10 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk8?label=jdk8%20image%20size) ![Docker Android 10 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk11?label=jdk11%20image%20size) ![Docker Android 10 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk17?label=jdk17%20image%20size) ![Docker Android 10 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-29-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;29.0.3        | 29.0.3  | Android SDK Build-Tools             | build-tools/29.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-29      | 5       | Android SDK Platform 29             | platforms/android-29/      |

{{< /details >}}

{{< details "See content of Android 11 (R) image" >}}

![Docker Android 11 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk8?label=jdk8%20image%20size) ![Docker Android 11 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk11?label=jdk11%20image%20size) ![Docker Android 11 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk17?label=jdk17%20image%20size) ![Docker Android 11 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-30-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;30.0.3        | 30.0.3  | Android SDK Build-Tools             | build-tools/30.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-30      | 3       | Android SDK Platform 30             | platforms/android-30/      |

{{< /details >}}

{{< details "See content of Android 12 (S) image" >}}

![Docker Android 12 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk8?label=jdk8%20image%20size) ![Docker Android 12 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk11?label=jdk11%20image%20size) ![Docker Android 12 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk17?label=jdk17%20image%20size) ![Docker Android 12 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-31-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;31.0.0        | 31.0.0  | Android SDK Build-Tools             | build-tools/31.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-31      | 1       | Android SDK Platform 31             | platforms/android-31/      |

{{< /details >}}

{{< details "See content of Android 12L image" >}}

![Docker Android 12L JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk8?label=jdk8%20image%20size) ![Docker Android 12L JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk11?label=jdk11%20image%20size) ![Docker Android 12L JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk17?label=jdk17%20image%20size) ![Docker Android 12 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-32-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;32.0.0        | 32.0.0  | Android SDK Build-Tools             | build-tools/32.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-32      | 1       | Android SDK Platform 32             | platforms/android-32/      |

{{< /details >}}

{{< details "See content of Android 13 (Tiramisu) image" >}}

![Docker Android 13 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk8?label=jdk8%20image%20size) ![Docker Android 13 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk11?label=jdk11%20image%20size) ![Docker Android 13 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk17?label=jdk17%20image%20size) ![Docker Android 13 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-33-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;33.0.2        | 33.0.3  | Android SDK Build-Tools             | build-tools/33.0.3/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-33      | 2       | Android SDK Platform 33             | platforms/android-33/      |

{{< /details >}}

{{< details "See content of Android 14 (Upside-down Cake) image" >}}

![Docker Android 14 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk8?label=jdk8%20image%20size) ![Docker Android 14 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk11?label=jdk11%20image%20size) ![Docker Android 14 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk17?label=jdk17%20image%20size) ![Docker Android 14 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-34-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;34.0.0        | 34.0.0  | Android SDK Build-Tools             | build-tools/34.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-34      | 3       | Android SDK Platform 34             | platforms/android-34/      |

{{< /details >}}

{{< details "See content of Android 15 (VanillaIceCream) image" >}}

![Docker Android 15 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk8?label=jdk8%20image%20size) ![Docker Android 15 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk11?label=jdk11%20image%20size) ![Docker Android 15 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk17?label=jdk17%20image%20size) ![Docker Android 15 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-35-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;35.0.1        | 35.0.1  | Android SDK Build-Tools             | build-tools/35.0.1/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 35.0.2  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-35      | 2       | Android SDK Platform 35             | platforms/android-35/      |

{{< /details >}}

{{< details "See content of Android 16 (Baklava) image" >}}

![Docker Android 16 JDK8 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk8?label=jdk8%20image%20size) ![Docker Android 16 JDK11 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk11?label=jdk11%20image%20size) ![Docker Android 16 JDK17 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk17?label=jdk17%20image%20size) ![Docker Android 16 JDK21 Size](https://img.shields.io/docker/image-size/alvrme/alpine-android/android-36-jdk21?label=jdk21%20image%20size)

| Path                      | Version | Description                         | Location                   |
|---------------------------|---------|-------------------------------------|----------------------------|
| build-tools;36.0.0        | 36.0.0  | Android SDK Build-Tools             | build-tools/36.0.0/        |
| extras;google;instantapps | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/ |
| patcher;v4                | 1       | SDK Patch Applier v4                | patcher/v4/                |
| platform-tools            | 36.0.0  | Android SDK Platform-Tools          | platform-tools/            |
| platforms;android-36      | 1       | Android SDK Platform 36             | platforms/android-36/      |

{{< /details >}}

## Container registries

Because of the [DockerHub rate limits](https://www.docker.com/increase-rate-limits), the image is now in three different containers registries:

* DockerHub: [Base Image](https://hub.docker.com/r/alvrme/alpine-android-base/tags) and [Android Image](https://hub.docker.com/r/alvrme/alpine-android/tags).
* GitHub Container Registry: [Base Image](https://github.com/users/alvr/packages/container/alpine-android-base/versions) and [Android Image](https://github.com/users/alvr/packages/container/alpine-android/versions).
* Quay: [Base Image](https://quay.io/repository/alvr/alpine-android-base?tab=tags) and [Android Image](https://quay.io/repository/alvr/alpine-android?tab=tags).

### As base image

Replace `<tag>` with one of the current [available tags](#tagging).

#### DockerHub's base image

You can use the Docker images from DockerHub as a base image for creating a new one:

```Dockerfile
FROM alvrme/alpine-android-base:<tag>
```

```Dockerfile
FROM alvrme/alpine-android:<tag>
```

#### GHCR's base image

You can use the Docker images from GitHub Container Registry as a base image for creating a new one:

```Dockerfile
FROM ghcr.io/alvr/alpine-android-base:<tag>
```

```Dockerfile
FROM ghcr.io/alvr/alpine-android:<tag>
```

#### Quay's base image

You can use the Docker images from Quay as a base image for creating a new one:

```Dockerfile
FROM quay.io/alvr/alpine-android-base:<tag>
```

```Dockerfile
FROM quay.io/alvr/alpine-android:<tag>
```

### Pulling

Replace `<tag>` with one of the current [available tags](#tagging).

#### DockerHub pulling

You can pull a specific Docker image from DockerHub with the following command:

```bash
docker pull alvrme/alpine-android-base:<tag>
```

```bash
docker pull alvrme/alpine-android:<tag>
```

#### GHCR pulling

You can pull a specific Docker image from GitHub Container Registry with the following command:

```bash
docker pull ghcr.io/alvr/alpine-android-base:<tag>
```

```bash
docker pull ghcr.io/alvr/alpine-android:<tag>
```

#### Quay pulling

You can pull a specific Docker image from Quay with the following command:

```bash
docker pull quay.io/alvr/alpine-android-base:<tag>
```

```bash
docker pull quay.io/alvr/alpine-android:<tag>
```

### Run container

Replace `<tag>` with one of the current [available tags](#tagging).

The command below will create a new container based on the specific image. It will open in the `/home/android` directory and the various [available commands](#tools-included) in the `PATH` will be able to be executed. Once the container is closed, it will be deleted. To keep the container after closing it, you have to remove `--rm` from the command.

#### DockerHub run container

Run the container from the DockerHub image:

```bash
docker run --rm -it alvrme/alpine-android-base:<tag>
```

```bash
docker run --rm -it alvrme/alpine-android:<tag>
```

#### GHCR run container

Run the container from the GitHub Container Registry image:

```bash
docker run --rm -it ghcr.io/alvr/alpine-android-base:<tag>
```

```bash
docker run --rm -it ghcr.io/alvr/alpine-android:<tag>
```

#### Quay run container

Run the container from the Quay image:

```bash
docker run --rm -it quay.io/alvr/alpine-android-base:<tag>
```

```bash
docker run --rm -it quay.io/alvr/alpine-android:<tag>
```

## Use in different CI/CD

Here are different configurations for some of the available CI/CD services. Before you start, remember that you must use Gradle's _wrapper_ and it needs execution permissions. To give execution permissions to an executable, add `chmod +x ./gradlew` to the steps, or use `git update-index --chmod=+x ./gradlew` in the repository and then _push_ the changes. This way, you don't have to give permissions every time.

### CircleCI

An example of CircleCI configuration. For more information, visit the [official documentation](https://circleci.com/docs/).

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
      - run: # Can omit if used `git update-index --chmod=+x ./gradlew` before.
         name: Chmod
         command: chmod +x ./gradlew
      - run:
          name: Download dependencies
          command: ./gradlew androidDependencies
      - save_cache:
          paths:
            - ~/.gradle
          key: jars-{{ checksum "build.gradle" }}-{{ checksum  "app/build.gradle" }}
      - run:
          name: Compile
          command: ./gradlew build
      - run:
          name: Testing
          command: ./gradlew lint test
      - run:
          name: Assemble
          command: |
            ./gradlew assembleRelease
            apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<keystore-pass> --key-pass pass:<alias-pass> app.apk # Passwords in plain
            apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<keystore-pass> --key-pass env:<alias-pass> app.apk # Passwords in envvar
```

### GitHub

An example of GitHub Actions configuration. For more information, visit the [official documentation](https://docs.github.com/en/actions).

```yaml:.github/workflows/android.yml
jobs:
  build:
    container:
      image: alvrme/alpine-android:android-<version>

    steps:
      - uses: actions/checkout@v2
      - name: Chmod # Can omit if used `git update-index --chmod=+x ./gradlew` before.
        run: chmod +x ./gradlew
      - uses: actions/cache@v2
        with:
          path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
          key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*') }}
          restore-keys: |
            ${{ runner.os }}-gradle-
      - name: Download dependencies
        run: ./gradlew androidDependencies
      - name: Build
        run: ./gradlew build
      - name: Testing
        run: ./gradlew lint test
      - name: Assemble
        run: |
          ./gradlew assembleRelease
          apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<keystore-pass> --key-pass pass:<alias-pass> app.apk # Passwords in plain
          apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<keystore-pass> --key-pass env:<alias-pass> app.apk # Passwords in envvar
```

### GitLab

An example of GitLab CI/CD configuration. For more information, visit the [official documentation](https://docs.gitlab.com/ee/ci/).

```yaml:.gitlab-ci.yml
image: alvrme/alpine-android:android-<version>

before_script:
  - export GRADLE_USER_HOME=`pwd`/.gradle
  - chmod +x ./gradlew # Can omit if used `git update-index --chmod=+x ./gradlew` before.

cache:
  key: "$CI_COMMIT_REF_NAME" # Optional: share cache between branches
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
    - apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass pass:<keystore-pass> --key-pass pass:<alias-pass> app.apk # Passwords in plain
    - apksigner sign --ks keystore.jks --ks-key-alias <alias> --ks-pass env:<keystore-pass> --key-pass env:<alias-pass> app.apk # Passwords in envvar
```
