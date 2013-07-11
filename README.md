## Jekyll based repository pages

Jeśli na gałęzi **gh-pages** repozytorium umieścimy plik *index.html*,
to będzie on dostępny pod takim url:

    http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉/

Na przykład, dla repozytorium *xxx* użytkownika *wbzyl*
będzie to:

    http://wbzyl.github.io/xxx/

Pliki HTML na gałęzi *gh-pages*, tworzą tak zwane **project pages**;
są to strony HTML przypisane do konkretnego repozytorium.

**Ćwiczenie 1.** Założyć przykładowe repozytorium
na serwerze *GitHub* i utworzyć w nim gałąź *gh-pages*.
Do gałęzi dodać taki plik HTML:

```html
<!doctype html>
<html lang='pl'>
  <meta charset='utf-8'>
  <title>My Repository Pages</title>
  <h1>My Repository Pages</h1>
```
**Uwaga:** Gałąź *gh-pages* tworzymy w taki sposób:

```sh
git checkout --orphan gh-pages
git rm -rf .
```

Dopiero teraz dodajemy do katalogu roboczego plik *index.html*,
dodajemy go do repozytorium, wykonujemy commit i push na GitHub:

```sh
git add index.html
git commit -m "dodano przykładową stronę index,html"
git push origin gh-pages
```

Po chwili sprawdzić, czy strona *index.html* jest dostępna.


## Blogging with Jekyll

Za pomocą programu *jekyll* przekonwertujemy strony wpisane w notacji
Markdown na HTML. Przy okazji zostaną dodane powtarzające się elementy
takie jak nagłówek, stopka. Fragement kodu zostaną podkolorowane,
a wzory matematyczne zapisane w notacji techowej zostaną przeskładane.

Zaczynamy od instalacji języka Ruby oraz gemów:

```sh
gem install jekyll
gem install coderay   # kolorowanie składni
gem install kramdown  # Markdown + LaTeX + kolorowanie składni przez coderay
```

TODO:

```sh
jekyll new jekyll
git add jekyll ; git commit -m "add generated jekyll template"

jekyll serve --watch
```

* Dodać pusty plik *.nojekyll*.
* Przenieść zawartość *_site/* na gałąź *gh-pages*.
* Sprawdzić, że ścieżki do plików CSS nie działają.
* Poprawić je.
* Kolorowanie składni: *coderay*. Wyjaśnić dlaczego nie *pygmentize*.
* Dodać MathJax.
