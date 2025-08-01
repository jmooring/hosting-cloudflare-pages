#!/usr/bin/env bash

#------------------------------------------------------------------------------
# @file
# Builds a Hugo site hosted on Cloudflare Pages.
#
# The Cloudflare Pages build image already includes Go, Hugo, and Node.js. Set
# the desired versions of these build tools in the wrangler.toml file in the
# root of this project.
#
# The Cloudflare Pages build image automatically installs Node.js dependencies.
#------------------------------------------------------------------------------

main() {

  # Install Dart Sass
  echo "Installing Dart Sass ${DART_SASS_VERSION}..."
  curl -sLJO "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  tar -C "${HOME}/.local" -xf "dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  rm dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz
  export PATH=${HOME}/.local/dart-sass:$PATH

  # Verify installed versions
  echo "Verifying installations..."
  echo Dart Sass: "$(sass --version)"
  echo Go: "$(go version)"
  echo Hugo: "$(hugo version)"
  echo Node.js: "$(node --version)"

  # https://gohugo.io/methods/page/gitinfo/#hosting-considerations
  if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
    git fetch --unshallow
  fi

  # https://github.com/gohugoio/hugo/issues/9810
  git config core.quotepath false

  # Build the site.
  hugo --gc --minify

}

set -euo pipefail
main "$@"
