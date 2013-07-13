#!/bin/bash

# ./fix-config.sh 'XXX Blog' /xxx/ blog/_config.yml

blog_name=${1:-My Awesome Blog}
repo_name=${2:-/}
config_file=${3:-blog/_config.yml}

sed "
/name/ c\\
name=${blog_name}

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
permalink: /articles/:year-:month-:day-:title.html\\
\\
baseurl: ${repo_name}

/pygments: true/ d
" $config_file


