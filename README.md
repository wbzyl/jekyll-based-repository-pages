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
git checkout --orphan gh-pages # create our branch, without any parents
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

Strony będziemy wpisywać w notacji Markdown.

Za pomocą programu *jekyll* będziemy konwertować strony na HTML. Przy
okazji *jekyll* doda do stron powtarzające się elementy takie jak
nagłówek, stopka. Fragmenty kodu zostaną podkolorowane, a wzory
matematyczne zapisane w notacji techowej zostaną przeskładane.

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
git add jekyll ; git commit -m "add generated jekyll template"
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

oglądamy wygenerowane strony tutaj *http://localhost:4000*.
i widzimy, że musimy poprawić kilka rzeczy:

----
![jekyll index page](/images/index-page.png)
----

na przykład: wpisać nazwę bloga i swoje dane.


## GitHub Pages

Program *jekyll* wygenerowane pliki zapisuje w katalogu **_site**.

Całą zawartość tego katalogu zapiszemy na gałęzi *gh-pages*.


**Uwaga:** GitHub może uruchomić program *jekyll* za nas.
My wygenerujemy strony sami. Dlaczego?
Gem Kramdown nie działa z Pygements. Wersje użytych gemów
przez GitHub i przez nas mogą być inne.


* Dodać pusty plik *.nojekyll*.
* Przenieść zawartość *_site/* na gałąź *gh-pages*.
* Sprawdzić, że ścieżki do plików CSS nie działają.
* Poprawić je.
* Kolorowanie składni: *coderay*. Wyjaśnić dlaczego nie *pygmentize*.
* Dodać MathJax.
