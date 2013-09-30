#!/bin/bash

# ./fix-config.sh /xxx 'My Awesome XXX Blog' blog/_config.yml

git_repo_name=${1:-}
blog_name=${2:-Your New Jekyll Site}

sed -i "
/name:/ c\\
name: ${blog_name}

/baseurl:/ c\\
baseurl: ${git_repo_name}
" _config.yml
