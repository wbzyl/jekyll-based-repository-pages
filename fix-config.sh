#!/bin/bash

# ./fix-config.sh blog/_config.yml xxl 'XXL Blog'

sed '
$ a\
\
markdown: kramdown\
\
kramdown:\
  use_coderay: true\
  coderay:\
    coderay_wrap: div\
    coderay_line_numbers: nil\
    coderay_tab_width: 2\
    coderay_css: class\
\
relative_permalinks: false\
\
permalink: /articles/:year-:month-:day-:title.html\
\
baseurl: /$2/

s/name: .*$/name: $3/
/pygments: true/d
' $1
