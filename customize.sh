#!/bin/bash

sed -i '
s|title: Your New Jekyll Site|title: My Awesome Blog|
s|<html>|<html lang="pl">|
s|<h1 class="title"><a href="/">|<h1 class="title"><a href="/">|
s|<a class="extra" href="/">home|<a class="extra" href="http://tao.inf.ug.edu.pl">home|
s|href="http://github.com/yourusername/">github.com/yourusername|href="http://github.com/wbzyl/">github.com/wbzyl|
s|Your Name|Włodek Bzyl|

s|br /|br|g

/What You Are/ d
/twitter.com/ d
/your@email.com/ d
' "$@"
