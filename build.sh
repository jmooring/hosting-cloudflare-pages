#!/usr/bin/env bash

#------------------------------------------------------------------------------
# @file
# Builds a Hugo site hosted on Cloudflare Pages.
#
# The Cloudflare Pages build image already includes Go, Hugo, and Node js. Set
# the desired versions in the wrangler.toml file in the root of this project.
#
# The Cloudflare Pages build image automatically installs Node.js dependencies.
#------------------------------------------------------------------------------

main() {

  # Install Dart Sass.
  echo "Installing Dart Sass ${DART_SASS_VERSION}..."
  curl -LJO "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  tar -xf "dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  cp -r dart-sass/ /opt/buildhome
  rm -rf dart-sass*
  export PATH=/opt/buildhome/dart-sass:$PATH

  # https://gohugo.io/methods/page/gitinfo/#hosting-considerations
  git fetch --recurse-submodules --unshallow

  # https://github.com/gohugoio/hugo/issues/9810
  git config core.quotepath false

  # Build the site.
  hugo --gc --minify

}

set -euo pipefail
main "$@"
