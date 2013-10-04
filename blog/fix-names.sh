#!/bin/bash

# run this from the blog/ directory
#
#   ./fix-config.sh /abc 'Blogging ABC'

git_repo_name=${1:-}
blog_name=${2:-Your New Jekyll Site}

sed -i "
/name:/ c\\
name: ${blog_name}

/baseurl:/ c\\
baseurl: ${git_repo_name}
" _config.yml

sed -i "
/h1 class=\"title\"/ c\\
          <h1 class=\"title\"><a href=\"${git_repo_name}/\">{{ site.name }}</a></h1>
" _layouts/default.html
