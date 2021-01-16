---
title: Hugo + CD + GitHub Pages
subtitle: Create a static website with the Hugo and GitHub Pages
description: Create a static website with the Hugo and GitHub Pages.

date: 2017-07-07T18:17:00+02:00
categories:
  - Server
  - Web
tags:
  - hugo
  - github
  - github pages
  - cd
  - ci
  - continuous deployment
  - continuous integration

image: /images/posts/2017/hugo-github/hugo-github.webp
translationKey: hugo-github
slug: hugo-github
---
{{< featuredImage alt="Hugo + GitHub" width=400 >}}

{{< notice info "Information" >}}
Much more complete alternatives can be used such as [Netlify](https://www.netlify.com/) or [Vercel](https://vercel.com/).
{{< /notice >}}

I have used WordPress, Grav and now Hugo throughout this blog. Unlike WordPress and Grav, [Hugo](https://gohugo.io) is a static web page generator. You don't need a server with PHP, Ruby, Python... Just download an executable on your computer and you're done.

<!--more-->

I will not comment on the operation, so if you want to know it in [this link](https://gohugo.io/overview/quickstart/) has the necessary.

## Requirements

Before we start we need to meet some requirements:

* **Two repositories**. One for Hugo and another for the generated content.
* **A CD service**. Like CircleCI or Travis. In this case I will use the first one.

## Configuration

In the root directory we will create three files: `deps.sh`, `push.sh` and, in this case, `circle.yml`

We will start by installing the necessary facilities. It's just downloading Hugo's executable and extracting it.

```bash:deps.sh
#!/bin/bash
HUGO_VERSION=0.25.1

set -e

wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
mkdir hugo_${HUGO_VERSION}
tar xvzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C hugo_${HUGO_VERSION}
cp hugo_${HUGO_VERSION}/hugo $HOME/bin/hugo
rm -rf hugo
```

To use another version of Hugo you only have to change the variable `HUGO_VERSION`

When you `push` on the Hugo repository, you have to update the other repository with the new content.

First you have to generate a [token](https://github.com/settings/tokens) and add it to the CircleCI/Travis/etcétera environment variables. This way you can make a `push` without having to write the password.

```bash:push.sh
#!/bin/bash
cd ./public

#echo myweb.dev > CNAME # Uncomment when using your own domain
git init
git config user.name "My name"
git config user.email "My email"
git remote add upstream "https://${GITHUB_TOKEN}@github.com/user/repository.git"
git fetch upstream
git reset upstream/master

git add -A .
git commit -m "user/hugo-repository@${CIRCLE_SHA1}"
git remote show upstream
git push -q upstream HEAD:master
```

And finally the configuration for the CI/CD service.

```yaml:circle.yml
dependencies:
  pre:
    - pip install Pygments # Necessary if highlight.js is not used
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
```

For CircleCI this would be the necessary configuration. If another system is to be used, the idea would be the same:

1. Install dependencies.
2. Execute Hugo as if it was a test, because if an error occurs it would not continue.
3. Publish the content generated in the other repository.
