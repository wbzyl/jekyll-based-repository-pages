#!/bin/bash

sed -i '
s|^<!DOCTYPE html>$|<!doctype html>|
s|^<html>$|<html lang="pl">|
s|<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">|\
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">\
        \
        <!-- configure and add MathJax -->\
        <script type="text/x-mathjax-config">\
          MathJax.Hub.Config({\
            displayAlign: "left",\
            displayIndent: "2em",\
            \
            TeX: {\
              extensions: ["color.js"],\
              Macros: {\
                MM: "{\\bf M}",\
                bold: ["{\\bf #1}",1]\
              }\
            },\
            \
            tex2jax: {\
              inlineMath: [ ["$","$"], ["\\(","\\)"] ],\
              displayMath: [ ["$$","$$"], ["\\[","\\]"] ],\
              balanceBraces: true,\
              processEscapes: true,\
              processEnvironments: true\
            },\
            \
            "HTML-CSS": {\
              preferredFont: "STIX",\
              styles: {\
                ".MathJax_Display": {\
                  "background-color": "#F0F0D8",\
                  padding: ".5em 0"\
                },\
                ".MathJax": {\
                  color: "#541F14",\
                }\
              }\
            }\
          });\
        </script>\
        <script src="http://cdn.mathjax.org/mathjax/2.2-latest/MathJax.js?config=TeX-AMS_HTML"></script>\
        |
' "$@"
