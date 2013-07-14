#!/bin/bash

# ./mathjax.sh blog/_layouts/default.html

sed -i '
s|^<!DOCTYPE html>$|<!doctype html>|
/<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">/ a\
        {% include mathjax.html %}
' "$@"
