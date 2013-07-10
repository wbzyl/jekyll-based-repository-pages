## Jekyll based repository pages

Jeśli utworzymy w repozytorium na serwerze Github gałąź o nazwie
**gh-pages** i umieścimy w niej plik o nazwie *index.html*, to będzie
on dostępny z takiego url:

    http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉

Na przykład, dla repozytorium *xxx* użytkownika *wbzyl*
będzie to:

    http://wbzyl.github.io/xxx

Pliki HTML na gałęzi *gh-pages*, to tak zwane **project pages**.
Innymi słowy, są to strony HTML przypisane do konkretnego
repozytorium.

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

Następnie dodajemy powyższy plik *index.html*, dodajemy go do
repozytorium, wykonujemy commit i push na GitHub:

```sh
git add index.html
git commit -m "dodano przykładową stronę index,html"
git push
```

Po kilku minutach sprawdzić, czy strona jest dostępna.
