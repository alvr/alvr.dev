#!/bin/bash
HUGO_VERSION=0.25.1

set -e

wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
mkdir hugo_${HUGO_VERSION}
tar xvzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C hugo_${HUGO_VERSION}
cp hugo_${HUGO_VERSION}/hugo $HOME/bin/hugo
rm -rf hugo