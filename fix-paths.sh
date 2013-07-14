#!/bin/bash

# ./fix-paths.sh blog/index.html blog/_layouts/default.html

sed -i "
s|href=\"{{ post.url }}\"|href=\"{{ site.baseurl }}{{ post.url }}\"|
s|href=\"/css/syntax.css\"|href=\"{{ site.baseurl }}/css/syntax.css\"|
s|href=\"/css/main.css\"|href=\"{{ site.baseurl }}/css/main.css\"|
" "$@"
