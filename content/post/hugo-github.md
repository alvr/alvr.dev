---
title: "Hugo + CD + Github Pages"
date: 2017-07-07T18:17:00+02:00
tags: [ "hugo", "github", "github pages", "CD" ]
---
He utilizado a lo largo de este blog WordPress, Grav y ahora Hugo. A diferencia de WordPress y Grav, [Hugo](https://gohugo.io) es un generador de páginas web estático no hace falta un servidor con PHP, Ruby, Python... Solo descargar un ejecutable en el ordenador y listo.

No voy a comentar el funcionamiento, por lo que si quieres conocerlo en [este enlace](https://gohugo.io/overview/quickstart/) tiene lo necesario.

# Requisitos
Antes de comenzar necesitamos cumplir unos requisitos:

*   **Dos repositorios**. Uno para Hugo y otro para el contenido generado.
*   **Un servicio de CD**. Como CircleCI o Travis. En este caso utilizaré el primero.

# Configuración
En el directorio raíz crearemos tres archivos: `deps.sh`, `push.sh` y, en este caso, `circle.yml`

## deps.sh
Empezaremos instalando las dependencias necesarias. Solamente es descargar el ejecutable de Hugo y extraerlo.

{{< highlight bash >}}
#!/bin/bash
HUGO_VERSION=0.25

set -e

wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
mkdir hugo_${HUGO_VERSION}
tar xvzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C hugo_${HUGO_VERSION}
cp hugo_${HUGO_VERSION}/hugo $HOME/bin/hugo
rm -rf hugo
{{</ highlight >}}

Para utilizar otra versión de Hugo solamente hay que cambiar la variable `HUGO_VERSION`

## push.sh
Cuando se haga `push` en el repositorio de Hugo, hay que actualizar el otro repositorio con el nuevo contenido.

Primero se tiene que generar un [token](https://github.com/settings/tokens) y agregarlo a las variables de entorno de CircleCI/Travis/etcétera. Así se puede hacer un `push` sin tener que escribir la contraseña.

{{< highlight bash >}}
#!/bin/bash
cd ./public

#echo miweb.me > CNAME # Descomentar al usar dominio propio
git init
git config user.name "Mi Nombre"
git config user.email "Mi correo"
git remote add upstream "https://${GITHUB_TOKEN}@github.com/usuario/repositorio.git"
git fetch upstream
git reset upstream/master

git add -A .
git commit -m "usuario/repositio-hugo@${CIRCLE_SHA1}"
git remote show upstream
git push -q upstream HEAD:master
{{</ highlight >}}

## circle.yml
{{< highlight yaml >}}
dependencies:
  pre:
    - pip install Pygments # Necesario si no se utiliza highlight.js
    - chmod +x ./deps.sh ./push.sh
    - ./deps.sh

test:
  override:
    - hugo

deployment:
  release:
    branch: master
    commands:
      - ./push.sh
{{</ highlight >}}

Para CircleCI esta sería la configuración necesaria. Si se va a utilizar otro sistema, la idea sería la misma:

1.  Instalar dependencias.
2.  Ejecutar Hugo como si fuera un test, ya que si se produce un error no continuaría.
3.  Publicar el contenido generado en el otro repositorio.
