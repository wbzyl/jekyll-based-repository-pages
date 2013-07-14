## Jekyll based repository pages

Jeśli do gałęzi **gh-pages** repozytorium dodamy plik *index.html*,
to będzie on dostępny pod takim URL:

    http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉/

Na przykład, dla repozytorium *xxx* użytkownika *wbzyl* będzie to taki URL:

    http://wbzyl.github.io/xxx/

Pliki na gałęzi *gh-pages*, tworzą tak zwane **project pages**.
Innymi słowy, są to strony WWW przypisane do konkretnego repozytorium.

**Ćwiczenie 1.** Założyć przykładowe repozytorium
na serwerze *GitHub* i utworzyć w nim gałąź *gh-pages*.
Do gałęzi dodać plik HTML o następującej zawartości:

```html
<!doctype html>
<html lang='pl'>
  <meta charset='utf-8'>
  <title>My Repository Pages</title>
  <h1>My Repository Pages</h1>
```
**Uwaga:**
[Gałąź *gh-pages* tworzymy w taki sposób](https://help.github.com/articles/creating-project-pages-manually):

```sh
git checkout --orphan gh-pages # create branch, without any parents
git rm -rf .                   # remove all files from the old working tree
```

Dopiero teraz dodajemy do katalogu roboczego i repozytorium plik
*index.html*, oraz wykonujemy commit i push na GitHub:

```sh
git add index.html
git commit -m "add sample page index,html"
git push origin gh-pages
```

Po chwili sprawdzić, czy strona *index.html* jest dostępna.


## Blogging with Jekyll

Strony będziemy wpisywać w notacji
[Markdown](http://www.ctrlshift.net/project/markdowneditor/), a wzory
matematyczne – w notacji techowej.

Do konwersji plików na HTML użyjemy programu *jekyll*. W trakcie
konwersji *jekyll* doda do plików HTML powtarzające się elementy:
nagłówki, stopki itp; fragmenty kodu zostaną podkolorowane, a wzory
matematyczne zapisane w notacji techowej zostaną przetłumaczone na
HTML.

Zaczynamy od instalacji języka Ruby oraz gemów
[Jekyll](https://github.com/mojombo/jekyll),
[CodeRay](http://coderay.rubychan.de/),
[Kramdown](http://kramdown.rubyforge.org/):

```sh
gem install jekyll
gem install coderay   # kolorowanie składni
gem install kramdown  # Markdown + LaTeX + kolorowanie składni przez coderay
```

Następnie generujemy szablon bloga w katalogu *blog*
i dodajemy wygenerowane pliki do repozytorium:

```sh
jekyll new blog
git add blog
git commit -m "add generated jekyll template"
```

Teraz z wygenerowanych szablonów generujemy strony HTML:

```sh
cd blog
jekyll build
```

i uruchamiamy wbudowany server WWW:

```sh
jekyll serve --watch
```

Oglądamy wygenerowane strony tutaj *http://localhost:4000*
i widzimy, że musimy poprawić kilka rzeczy:

----
![jekyll index page](/images/index-page.png)

Na przykład: wpisać swoją nazwę bloga i swoje dane.
Ale tymi poprawkami zajmiemy się później.


## GitHub Pages

Chociaż gałąź *gh-pages* jest automatycznie „przepuszczana” przez
program *jekyll*
(a wygenerowane strony są serwowane przez serwer GitHub),
to my **nie będziemy** korzystać z tego mechanizmu.
Dlaczego? Ponieważ wersje gemów użytych przez GitHub i przez nas mogą
być różne; dodatkowo kolorowanie składni w Kramdown nie działa
na serwerze GitHub.

Program *jekyll* generowane strony zapisuje w katalogu *\_sites*.
Dodamy ten katalog do repozytorium.

W tym celu usuwamy linijkę zawierającą
*_site* z pliku *.gitignore* i wykonujemy:

```sh
git add _site/
git commit -m "dodano katalog _site do repo"
```

Dodajemy pusty plik *.nojekyll*, który informuje serwer
GitHub, aby nie uruchamiał automatycznie programu *jekyll*:

```sh
touch _site/.nojekyll
git add _site/.nojekyll
git commit -m "dodano plik .nojekyll do katalogu _site"
```

**Dopiero teraz przenosimy zawartość katalogu *_site* na gałąź
*gh-pages*.**

```sh
git checkout gh-pages
git read-tree -m -u master:blog/_site/
git commit -m 'copy content of blog/ from master to gh-pages'
git push origin gh-pages
git checkout master
```
Wchodzimy na stronę

```sh
 http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉/
```

i widzimy, że *jekyll* wygenerował nipoprawne ścieżki do plików CSS:

----
![jekyll index page](/images/index-gh-page.png)

Po kliknięciu w link posta *Welcome Jekyll!*, przekonujemy się
że ten link nie działa.

Podsumowując mamy kilka rzeczy do poprawy. Oto cała lista:

1. Skonfigurować program *jekyll* – *fix-config.sh*.
2. Zmienić nazwę bloga, wpisać swoje dane do szablonów – *customize.sh*.
3. Poprawić nieprawidłowe ścieżki – *fix-paths.sh*.
4. Dodać MathJax – *mathjax.sh*.

Wszystkie te poprawki wykonamy korzystając ze skryptów
napisanych w języku powłoki Bash.


#### *fix-config.sh*

Korzystamy z programu *sed*:

```sh
#!/bin/bash

blog_name=${1:-My Awesome Blog}
repo_name=${2:-/}
config_file=${3:-blog/_config.yml}

sed -i "
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
```

Przykładowe wywołanie:

```sh
./fix-config.sh /xxx/ 'My Awesome XXX Blog' blog/_config.yml
```

#### *fix-paths.sh*

Korzystamy z programu *sed*:

```sh
#!/bin/bash

sed -i "
s|href=\"{{ post.url }}\"|href=\"{{ site.baseurl }}{{ post.url }}\"|
s|href=\"/css/syntax.css\"|href=\"{{ site.baseurl }}css/syntax.css\"|
s|href=\"/css/main.css\"|href=\"{{ site.baseurl }}css/main.css\"|
" "$@"
```

Wywołanie skryptu:

```sh
./fix-paths.sh blog/index.html blog/_layouts/default.html
```

Po tych zmianach i uruchomieniu serwera:

```sh
jekyll serve --watch
```

blog będzie dostępny lokalnie z takiego URL:

```
http://localhost:4000/abc/  #<= z ukośnikiem `/` na końcu url
```

#### *customize.sh*

Korzystamy z programu *sed*:

```sh
#!/bin/bash
# ./customize.sh

name=${1:-}
name=${2:-}

sed -i "
s|Your New Jekyll Site|XXL Blog|
s|github.com/yourusername|github.com/wbzyl|g
s|twitter.com/yourusername|twitter.com/wbzyl|g
s|Your Name|Włodek Bzyl|
s|What You Are|Twitter|
/your@email.com/d
s|name: Your New Jekyll Site|name: XXL Blog|
s|br /|br|g
" "$@"

Przykładowe wywołanie:

```sh
./customize.sh ...
```

#### *mathjax.sh*
