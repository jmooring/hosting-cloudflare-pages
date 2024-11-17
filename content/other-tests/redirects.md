+++
title = 'Redirects'
summary = 'This page summarizes how redirects behave.'
date = 2024-11-17T14:51:42-08:00
weight = 60
+++

The Cloudflare Pages configuration for this site includes two 301 redirect rules using wildcard patterns:

Request URL|Target URL
:--|:--
`https://boldbeam.com/*`|`https://www.boldbeam.com/${1}`
`https://www.boldbeam.com/?p=*`|`https://www.boldbeam.com/p${1}/`

While building the site Hugo publishes a _redirects file to the root of the public directory. Each entry is derived from the `aliases` front matter field.

```text
/p1/ /posts/post-1/ 301
/p2/ /posts/post-2/ 301
/p3/ /posts/post-3/ 301
```

The resulting request/redirect chain looks like this:

```text
https://boldbeam.com/?p=1

    ↓ (301 redirect)

https://www.boldbeam.com/?p=1

    ↓ (301 redirect)

https://www.boldbeam.com/p1/

    ↓ (301 redirect)

https://www.boldbeam.com/posts/post-1/
```

Inspect the redirects with:

```text
curl -sLD - https://boldbeam.com/?p=1 -o /dev/null -w '%{url_effective}'
```

Use these links to test the redirect rules:

Request URL|Target URL
:--|:--
https://boldbeam.com|`https://www.boldbeam.com`
https://www.boldbeam.com/?p=1|`https://www.boldbeam.com/posts/post-1/`
https://www.boldbeam.com/?p=2|`https://www.boldbeam.com/posts/post-2/`
https://www.boldbeam.com/?p=3|`https://www.boldbeam.com/posts/post-3/`
https://boldbeam.com/?p=1|`https://www.boldbeam.com/posts/post-1/`
https://boldbeam.com/?p=2|`https://www.boldbeam.com/posts/post-2/`
https://boldbeam.com/?p=3|`https://www.boldbeam.com/posts/post-3/`
