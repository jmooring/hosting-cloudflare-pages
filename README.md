# Hosting Test - Cloudflare Pages

This is a test of hosting a Hugo site on Cloudflare Pages.

This site:

1. Includes content from a Hugo module
1. Transpiles Sass to CSS using Dart Sass
1. Performs vendor prefixing of CSS rules using the postcss, postcss-cli, and autoprefixer Node.js packages
1. Processes CSS files using the tailwindcss and @tailwindcss-cli Node.js packages
1. Encodes images to the WebP format to verify that we're using Hugo's extended edition
1. Includes a content file named hugö.md to verify that the Git `core.quotepath` setting is `false`[^1].

Cloudflare uses Zstd compression, which is faster to compress/decompress than Brotli, but the compression ratio is generally lower than Brotli. This difference is noise.

[^1]: See [issue #9810](https://github.com/gohugoio/hugo/issues/9810). Git's `core.quotepath` setting is `false` if `/tests/hugö` has a non-zero "last modified" date.
