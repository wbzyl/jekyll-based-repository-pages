#!/bin/bash

# ./fix-config.sh /xxx 'My Awesome XXX Blog' blog/_config.yml

git_repo_name=${1:-}
blog_name=${2:-Your New Jekyll Site}
config_file=${3:-blog/_config.yml}

sed -i "
/name:/ c\\
name: ${blog_name}

$ a\\
\\
markdown: kramdown\\
\\
kramdown:\\
  use_coderay: true\\
  coderay:\\
    coderay_wrap: div\\
    coderay_line_numbers: nil\\
    coderay_tab_width: 2\\
    coderay_css: class\\
\\
relative_permalinks: false\\
permalink: articles/:year-:month-:day-:title.html\\
\\
baseurl: ${git_repo_name}

/pygments: true/ d
" $config_file


