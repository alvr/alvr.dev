---
title: Alpine Android
subtitle: 🐋 Small docker image for building & testing Android applications
description: 🐋 Small docker image for building & testing Android applications.

date: 2017-03-29T22:44:00+02:00
categories: 
  - Android
  - Docker
tags: 
  - alpine
  - cd
  - ci
  - ci/cd
  - continuous deployment
  - continuous integration
  - google play

translationKey: alpine-android
type: showcase

link: /en/projects/docker/alpine-android/
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

## Description

Alpine Android is a lightweight Docker image for compiling and testing Android applications. Based on Alpine's image, it makes the size smaller compared to Debian or Ubuntu based images. Also, there are different images per SDK and only the minimum packages are included.

SDK versions from Android 21 to Android 30 are available. Each version of the SDK has its own image, being the identifier `alvrme/alpine-android:android-<version>`. If you always want to refer to the latest stable Android version available, you can also use `alvrme/alpine-android:latest`.

{{< notice info "Versioning" >}}
Note that when version 31 of the SDK is released, if you want to continue using version 30, it is better to use the version tag.
{{< /notice >}}

## Alpine Android Base

All images extend from a base image. This image, based on [AdoptOpenJDK8 Alpine](https://hub.docker.com/r/adoptopenjdk/openjdk8), contains the basic tools needed to compile and test any Android application or library whose `compileSdkVersion` is between version 21 (Android 5 / Lollipop) and version 30 (Android 11).

This makes it easy to update the images that extend from it, since only the necessary `Dockerfile` would have to be modified.

### Use as a base image

To extend the base image and be able to configure your own image with the packages and applications you want, just add the following line to the top of `Dockerfile`:

```dockerfile
FROM alvrme/alpine-android-base
```

### Install applications and packages

You can install any Alpine application from the [following list](https://pkgs.alpinelinux.org/packages?name=&branch=v3.12&arch=x86_64) by adding the following command to the `Dockerfile

```dockerfile
RUN apk add --no-cache <package1> <package2> <...> && \
    rm -rf /tmp/* /var/tmp/*
```

Similarly, you can install any [available package](https://gist.github.com/alvr/8db356880447d2c4bbe948ea92d22c23) of Android:

```dockerfile
RUN sdkmanager --sdk_root=${ANDROID_HOME} --install <package1> <package2> <...>
```

## Tools included

Below is a list of all the tools included with the installation of the different packages. Those with their own documentation are linked.

{{< notice info "Gradle" >}}
The `gradle` package is not installed, so the command in the `PATH` is not available. The reason for this is that the package may be outdated and not compatible with any of the APIs used in the configuration. That's why you should always use the _wrapper_ that comes with the project and whose version is indicated in the `gradle-wrapper.properties` file. You can consult [here](#use-in-different-cicd) how to configure the _wrapper_ to use it in the different CI/CD services.
{{< /notice >}}

### Command-line tools

<!-- markdownlint-disable MD033 -->
* <code>[apkanalyzer](https://developer.android.com/studio/command-line/apkanalyzer?hl=en)</code>: Provides insight into the composition of your APK after the build process completes.
* <code>[avdmanager](https://developer.android.com/studio/command-line/avdmanager?hl=en)</code>: Allows you to create and manage Android Virtual Devices (AVDs) from the command line.
* <code>[lint](https://developer.android.com/studio/command-line/lint?hl=en)</code>: A code scanning tool that can help you to identify and correct problems with the structural quality of your code.
* `screenshot2`: Do a screenshot of the running emulator.
* <code>[sdkmanager](https://developer.android.com/studio/command-line/sdkmanager?hl=en)</code>: Allows you to view, install, update, and uninstall packages for the Android SDK.
<!-- markdownlint-enable MD033 -->

### SDK build tools

<!-- markdownlint-disable MD033 -->
* <code>[aapt2](https://developer.android.com/studio/command-line/aapt2?hl=en)</code>: Parses, indexes, and compiles Android resources into a binary format that is optimized for the Android platform, and packages the compiled resources into a single output.
* <code>[apksigner](https://developer.android.com/studio/command-line/apksigner?hl=en)</code>: Signs APKs and checks whether APK signatures will be verified successfully on all platform versions that a given APK supports.
* <code>[zipalign](https://developer.android.com/studio/command-line/zipalign?hl=en)</code>: Optimizes APK files by ensuring that all uncompressed data starts with a particular alignment relative to the start of the file.
<!-- markdownlint-enable MD033 -->

### SDK platform tools

<!-- markdownlint-disable MD033 -->
* <code>[adb](https://developer.android.com/studio/command-line/adb?hl=en)</code>: Android Debug Bridge (adb) is a versatile tool that lets you manage the state of an emulator instance or Android-powered device. You can also use it to install an APK on a device.
* <code>[etc1tool](https://developer.android.com/studio/command-line/etc1tool?hl=en)</code>: A command line utility that lets you encode PNG images to the ETC1 compression standard and decode ETC1 compressed images back to PNG.
* `fastboot`: Flashes a device with platform and other system images.
* <code>[logcat](https://developer.android.com/studio/command-line/logcat?hl=en)</code>: This is a tool invoked via adb to view app and system logs.
<!-- markdownlint-enable MD033 -->

### Other tools

<!-- markdownlint-disable MD033 -->
* <code>[ia](https://developer.android.com/topic/google-play-instant/getting-started/instant-enabled-app-bundle?hl=en#build)</code>: Check and run an instant application.
<!-- markdownlint-enable MD033 -->

In addition to the above Android-specific tools, the [BusyBox commands](https://busybox.net/downloads/BusyBox.html) and packages installed on the base image are also available:

* `git`
* `unzip`
* `wget`

## Extras

The base image also includes the `extras` command that contains small utilities that are not installed by default, since their use is not widespread.

These extras are executed with the command `extras <command>` and are the following

### Fastlane

[fastlane](https://github.com/fastlane/fastlane) is a tool for iOS and Android developers to automate tedious tasks like generating screenshots, dealing with provisioning profiles, and releasing your application. Visit their [documentation](https://docs.fastlane.tools/) for more information.

This command allows you to install `fastlane`. There are two variants:

```bash
extras fastlane
```

This command allows you to install the latest version of `fastlane`. If you want to use a specific version, the command is as follows:

```bash
extras fastlane <version>
```

## Pull from DockerHub

To download an image from DockerHub just execute the following command for the version you want to download:

| API level         | Command                                        |
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

## Run as a container

| API level         | Command                                                |
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

The above command will create a new container based on the specific image. It will open in the `/home/android` directory and the various [available commands](#tools-included) in the `PATH` will be able to be executed. Once the container is closed, it will be deleted. To keep the container after closing it, you have to remove `--rm` from the command.

## Content of each image

### Base image

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |

### Android 21

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;21.1.2          | 21.1.2  | Android SDK Build-Tools             | build-tools/21.1.2/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-21        | 2       | Android SDK Platform 21             | platforms/android-21/        |

### Android 22

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;22.0.1          | 22.0.1  | Android SDK Build-Tools             | build-tools/22.0.1/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-22        | 2       | Android SDK Platform 22             | platforms/android-22/        |

### Android 23

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;23.0.3          | 23.0.3  | Android SDK Build-Tools             | build-tools/23.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-23        | 3       | Android SDK Platform 23             | platforms/android-23/        |

### Android 24

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;24.0.3          | 24.0.3  | Android SDK Build-Tools             | build-tools/24.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-24        | 2       | Android SDK Platform 24             | platforms/android-24/        |

### Android 25

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;25.0.3          | 25.0.3  | Android SDK Build-Tools             | build-tools/25.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-25        | 3       | Android SDK Platform 25             | platforms/android-25/        |

### Android 26

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;26.0.3          | 26.0.3  | Android SDK Build-Tools             | build-tools/26.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-26        | 2       | Android SDK Platform 26             | platforms/android-26/        |

### Android 27

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;27.0.3          | 27.0.3  | Android SDK Build-Tools             | build-tools/27.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-27        | 3       | Android SDK Platform 27             | platforms/android-27/        |

### Android 28

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;28.0.3          | 28.0.3  | Android SDK Build-Tools             | build-tools/28.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-28        | 6       | Android SDK Platform 28             | platforms/android-28/        |

### Android 29

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;29.0.3          | 29.0.3  | Android SDK Build-Tools             | build-tools/29.0.3/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-29        | 5       | Android SDK Platform 29             | platforms/android-29/        |

### Android 30

| Path                        | Version | Description                         | Location                     |
|-----------------------------|---------|-------------------------------------|------------------------------|
| build-tools;30.0.2          | 30.0.2  | Android SDK Build-Tools             | build-tools/30.0.2/          |
| extras;google;instantapps   | 1.9.0   | Google Play Instant Development SDK | extras/google/instantapps/   |
| patcher;v4                  | 1       | SDK Patch Applier v4                | patcher/v4/                  |
| platform-tools              | 30.0.5  | Android SDK Platform-Tools          | platform-tools/              |
| platforms;android-30        | 3       | Android SDK Platform 30             | platforms/android-30/        |

## Use in different CI/CD

Here are different configurations for some of the available CI/CD services. Before beginning, ther

Aquí hay diferentes configuraciones para algunos de los distintos servicios de CI/CD disponibles. Before you start, remember that you must use Gradle's _wrapper_ and it needs execution permissions. To give execution permissions to an executable, add `chmod +x ./gradlew` to the steps, or use `git update-index --chmod=+x ./gradlew` in the repository and then _push_ the changes. This way, you don't have to give permissions every time.

### CircleCI

An example of CircleCI configuration. For more information, visit the [official documentation](https://circleci.com/docs/).

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

An example of GitHub Actions configuration. For more information, visit the [official documentation](https://docs.github.com/en/free-pro-team@latest/actions).

```yaml:.github/workflows/android.yml
jobs:
  build:
    container:
      image: alvrme/alpine-android:android-30

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
image: alvrme/alpine-android:android-30

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

## Statistics

[![dockeri.co](https://dockeri.co/image/alvrme/alpine-android-base)](https://hub.docker.com/r/alvrme/alpine-android-base)
[![dockeri.co](https://dockeri.co/image/alvrme/alpine-android)](https://hub.docker.com/r/alvrme/alpine-android)

## Links

{{< button href="https://github.com/alvr/alpine-android" color="primary" >}}**GitHub**{{</ button >}}

{{< button href="https://hub.docker.com/r/alvrme/alpine-android" color="primary" >}}**Docker Alpine Android**{{</ button >}}
{{< button href="https://hub.docker.com/r/alvrme/alpine-android-base" color="primary" >}}**Docker Alpine Android Base**{{</ button >}}
