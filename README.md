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

na przykład: wpisać swoją nazwę bloga i swoje dane.
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

W tym celu usuwamy linijkę z *_site* z pliku *.gitignore* i wykonujemy:

```sh
git add _site/
git commit -m "dodano katalog _site do repo"
```

Przy okazji dodajemy pusty plik *.nojekyll*, który informuje serwer
GitHub, aby nie uruchamiał automatycznie programu *jekyll*:

```sh
touch _site/.nojekyll
git add _site/.nojekyll
git commit -m "dodano plik .nojekyll do katalogu _site"w
```

**Dopiero teraz przenosimy zawartość katalogu *_site* na gałąź
*gh-pages*.**

```sh
git checkout -b gh-pages
git read-tree -m -u master:blog/_site/
git commit -m 'copy content of blog/ from master to gh-pages'
git push origin gh-pages
git checkout master
```
Wchodzimy na stronę

```sh
 http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉/
```

i widzimy, że nie działają ścieżki do plików CSS:

----
![jekyll index page](/images/index-gh-page.png)

Niepoprawny jest też link do posta *Welcome Jekyll!.


### Fix paths

Ścieżki poprawimy korzystając z skryptu *fix-paths.sh*:

```sh

```

Skrypt uruchamiamy podając ścieżki do plików:

```sh
./fix-paths.sh blog/config.yml blog/index.html _layout/default.html
```




**TODO:** Dodać MathJax.
