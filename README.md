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
**Uwaga:** Gałąź *gh-pages* utworzymy na dwa sposoby.
Pierwszy sposób polega na przeklikaniu kawałka
interfejsu repozytorium. Drugi, manualny, to wpisanie
kilku poleceń na konsoli.

1\. Klikamy kolejno
w `Settings` → `Automatic Page Generator` → `Continue to Layouts` → `Publish`

![Settings](/images/gh-pages-1.png)  
![Automatic Page Generator](/images/gh-pages-2.png)  
![Continue to Layouts](/images/gh-pages-3.png)  
![Hide Edit Publish](/images/gh-pages-4.png)

Następnie, jeśli tego nie zrobiliśmy wcześniej, klonujemy repozytorium.
Klikamy w tabliczkę ze strzałką:

![SSH clone URL](/images/gh-pages-5.png)

Na konsoli wpisujemy `git clone `, wciskamy
klawisze SHIFT+CTRL+V i wykonujemy polecenie wciskając klawisz Enter.

Na koniec, z katalogu z repozytorium, wchodzimy na nowo utworzoną
gałąź *gh-pages*:

```sh
git pull
git checkout --track origin/gh-pages
```

2\. [Manualnie](https://help.github.com/articles/creating-project-pages-manually):

```sh
git checkout --orphan gh-pages # create branch, without any parents
```

 


Po założeniu gałęzi *gh-pages* usuwamy niepotrzebne pliki:

```sh
git rm -rf .                   # remove all files from the old working tree
```

i dodajemy do katalogu roboczego i repozytorium plik
*index.html*, oraz wykonujemy commit i push na GitHub:

```sh
git add index.html
git commit -m "add sample page index,html"
git push origin           # dla sposobu „klikanie”
git push origin gh-pages  # dla sposobu „manualny”
```

Jeśli wszystkie te polecenia wykonały się bez błędów, to
wracamy na gałąź ***master***:

```sh
git checkout master
```

Po chwili sprawdzamy, czy strona *index.html* jest dostępna.


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
i dodajemy wygenerowane pliki do repozytorium. Polecenia
wykonujemy w katalogu głównym repozytorium:

```sh
jekyll new blog                                # generujemy szablon
git add blog
git commit -m "add generated jekyll template"
```

Z wygenerowanych szablonów generujemy „statyczne” strony HTML:

```sh
cd blog
jekyll build
```

Sprawdzamy co się wygenerowało uruchamiając wbudowany server WWW:

```sh
jekyll serve --watch
```

i oglądając wygenerowane strony w przeglądarce *http://localhost:4000*.

Widzimy, że jest kilka rzeczy do poprawy.

----
![jekyll index page](/images/index-page.png)

Przykładowo, należy wpisać swoją nazwę bloga i swoje dane.
Ala poprawkami zajmiemy się później.


## GitHub Pages

Na początek dwie uwagi:

1\. Chociaż gałąź *gh-pages* jest automatycznie „przepuszczana” przez
program *jekyll*
(a wygenerowane strony są serwowane przez serwer GitHub),
to my **nie będziemy** korzystać z tego mechanizmu.
Dlaczego? Ponieważ wersje gemów użytych przez GitHub i przez nas mogą
być różne.

2\. Generowanie wzorów matematycznych działa tylko
z gemem Kramdown, a kolorowanie składni z Kramdown nie działa na
serwerze GitHub.

✦✦✦

Program *jekyll* generowane strony zapisuje w katalogu *\_sites*.
Dodamy ten katalog do repozytorium. W tym celu usuwamy linijkę
zawierającą *_site* z plików *.gitignore* (lub usuwamy wszystkie te
pliki) i wykonujemy:

```sh
git add _site/
git commit -m "dodano katalog _site do repo"
```

Do katalogu *blog* dodajemy pusty plik *.nojekyll*, który informuje
serwer GitHub, aby nie uruchamiał automatycznie programu *jekyll*:

```sh
cd blog
touch _site/.nojekyll
git add _site/.nojekyll
git commit -m "dodano plik .nojekyll do katalogu _site"
git push
cd ..
```

**Dopiero teraz przenosimy zawartość katalogu *_site* na gałąź *gh-pages*.**

```sh
git checkout gh-pages
git read-tree -m -u master:blog/_site/
git commit -m 'copy content of blog/ from master to gh-pages'
git push origin gh-pages
# albo: git push
git checkout master
```
Wchodzimy na stronę

```sh
 http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉/
```

i widzimy, że *jekyll* wygenerował niepoprawne ścieżki do plików CSS:

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

git_repo_name=${1:-}
blog_name=${2:-Your New Jekyll Site}
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
permalink: articles/:year-:month-:day-:title.html\\
\\
baseurl: ${git_repo_name}

/pygments: true/ d
" $config_file
```

Przykładowe wywołanie z katalogu głównego repozytorium:

```sh
./fix-config.sh /xxx 'Your New Jekyll Site' blog/_config.yml
```

#### *fix-paths.sh*

Ponownie korzystamy z programu *sed*:

```sh
#!/bin/bash
sed -i "
s|href=\"{{ post.url }}\"|href=\"{{ site.baseurl }}{{ post.url }}\"|
s|href=\"/css/syntax.css\"|href=\"{{ site.baseurl }}/css/syntax.css\"|
s|href=\"/css/main.css\">|href=\"{{ site.baseurl }}/css/main.css\">\n\
        <link rel=\"stylesheet\" href=\"{{ site.baseurl }}/css/custom.css\">|
" "$@"
```

Wywołanie skryptu:

```sh
./fix-paths.sh blog/index.html blog/_layouts/default.html
```

Po tych zmianach i uruchomieniu serwera z katalogu *blog*:

```sh
cd blog
jekyll serve --watch
```

blog będzie dostępny lokalnie z takiego URL:

```
http://localhost:4000/〈baseurl〉/  #<= z ukośnikiem `/` na końcu url
```

gdzie *baseurl* zostało dopisane do pliku *_config.yml* przez
poprzedni skrypt.


#### *customize.sh*

Oczywiście w skrypcie poniżej wstawiamy swoje dane:

```sh
#!/bin/bash

sed -i '
s|title: Your New Jekyll Site|title: Your New Jekyll Site|
s|<html>|<html lang="pl">|
s|<h1 class="title"><a href="/">|<h1 class="title"><a href="/">|
s|<a class="extra" href="/">home|<a class="extra" href="http://tao.inf.ug.edu.pl">home
s|href="http://github.com/yourusername/">github.com/yourusername|href="http://github.com/wbzyl/">github.com/wbzyl/|
s|Your Name|Włodek Bzyl|

s|br /|br|g

/What You Are/ d
/twitter.com/ d
/your@email.com/ d
' "$@"

Przykładowe wywołanie:

```sh
./customize.sh blog/index.html blog/_layouts/default.html
```

#### *mathjax.sh*

Wykonamy w trzech krokach.

1\. Skorzystamy ze skryptu poniżej, aby dopisać
`{% include mathjax.html %}` do pliku *_layouts/default.html*.

```sh
#!/bin/bash

sed -i '
s|^<!DOCTYPE html>$|<!doctype html>|
/<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">/ a\
        {% include mathjax.html %}
' "$@"
```

Uruchomić powyższy skrypt z katalogu głównego repozytorium:

```sh
./mathjax.sh blog/_layouts/default.html
```

2\. W katalogu głównym repozytorium utworzyć katalog *_includes*
i dodać do niego plik *mathjax.html* o takiej zawartości:

```html
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  displayAlign: "left",
  displayIndent: "2em",

  TeX: {
    extensions: ["color.js"],
    Macros: {
      MM: "{\bf M}",
      bold: ["{\bf #1}",1]
    }
  },

  tex2jax: {
    inlineMath: [ ["$","$"] ],
    displayMath: [ ["$$","$$"] ],
    balanceBraces: true,
    processEscapes: true,
    processEnvironments: true
  },

  "HTML-CSS": {
    preferredFont: "STIX",
    styles: {
      ".MathJax_Display": {
        "background-color": "#F0F0D8",
        padding: ".5em 0"
      },
      ".MathJax": {
        color: "#541F14",
      }
    }
  }
});
</script>
<script src="http://cdn.mathjax.org/mathjax/2.2-latest/MathJax.js?config=TeX-AMS_HTML"></script>
```

3\. Dodać przykładowy post do katalogu *_posts*:

```html
---
layout: post
title:  "Welcome to MathJax!"
date:   2013-06-26 16:16:16
categories: jekyll kramdown latex math
---

TeX + MathJax examples:

<blockquote>
<p>
  Finally, you are going to have to do more work to protect the
  mathematics from the Markdown engine so that things like underscores
  and backslashes don’t get processed by Markdown when they appear in
  mathematics. That is a bit tricky, but without that, you will run into
  lots of problems with your TeX code not getting processed properly.
</p>
<p class="source">— Davide Cervone</p>
</blockquote>

$$A = \left[\matrix{1&2&3\cr4&5&6\cr7&8&9\cr}\right]
$$

$$\{\underbrace{\overbrace{\mathstrut a,\ldots,a}^{k\;a'\rm s},
  \overbrace{\mathstrut b,\ldots,b}^{l\;b'\rm s}\>}_{k+1\rm\;elements}\}
$$

$$\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+x}}}}}}}
$$

$$\delta\colon {\Bbb R}^3 \to {\Bbb R}
$$

$$M = \pmatrix{\pmatrix{a&b\cr c&d} & \pmatrix{e&f\cr g&h}\cr
  \bbox[#B2D1E5,1em]{0}&\pmatrix{i&j\cr k&l}}
$$

$$\sum_{i=1}^{n} i = \bbox[#86C543,0.25em]{n(n+1)\over2}
$$

$$n_1 + n^2_1 = 4
$$

$${(n_1+n_2+\cdots+n_m)!\over n_1!\,n_2!\ldots n_m!}
  ={n_1+n_2\choose n_2}
  \ldots{n_1+n_2+\cdots+n_m\choose n_m}
$$

Aby podejrzeć jak zostały wpisane wzory najeżdżamy myszką
na wzór i klikamy go prawym przyciskiem.
```

Teraz powinniśmy przejrzeć post z matematyką.


### Plugins: LESS → CSS converter

Najpierw zainstalujemy potrzebne gemy:

```sh
gem install less
gem install therubyracer
```

Tworzymy katalog *_plugins* i dodajemy do niego plik *less_converter.rb* o zawartości:

```ruby
require 'less'

module Jekyll
  class LessConverter < Converter
    safe true
    priority :high

    def setup
      return if @setup
      require 'less'
      @setup = true
    rescue LoadError
      STDERR.puts 'You are missing the library required for less. Please run:'
      STDERR.puts ' $ [sudo] gem install less'
      raise FatalException.new("Missing dependency: less")
    end

    def matches(ext)
      ext =~ /.less/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      setup
      begin
        parser = Less::Parser.new
        parser = parser.parse(content).to_css
      rescue => e
        puts "Less Exception: #{e.message}"
      end
    end

  end
end
```

Następnie zmieniamy nazwę pliku *css/main.css* na
*css/main.less* i przepisujemy kod CSS na LESS. Oto wynik konwersji
z wymaganym nagłówkiem YAML:

```css
---
title: main CSS
---
// Common
* {
  margin: 0;
  padding: 0;
}
html, body { height: 100%; }
body {
  background-color: #FFF;
  font-family: Helvetica, Arial, sans-serif;
  text-align: center;
}
h1, h2, h3, h4, h5, h6 {
  font-size: 100%; }
h1 { margin-bottom: 1em; }
p { margin: 1em 0; }
a { color: #00a;
  &:hover   { color: #000; }
  &:visited { color: #a0a; }
}

// Home
ul.posts {
  list-style-type: none;
  margin-bottom: 2em;
  li {
    line-height: 1.75em;
  }
  span {
    color: #aaa;
    font-family: Monaco, "Courier New", monospace;
    font-size: 80%;
  }
}

// Site
.site {
  text-align: justify;
  width: 42em;
  margin: 3em auto 2em;
  line-height: 1.5em;
  .header {
    a {
      font-weight: bold;
      text-decoration: none;
    }
    h1.title {
      display: inline-block;
      margin-bottom: 2em;
      a {
        color: #a00;
        &:hover {
          color: #000;
        }
      }
    }
    a.extra {
      color: #aaa;
      margin-left: 1em;
      &:hover {
        color: #000;
      }
    }
  }
  .meta {
    color: #aaa;
  }
  .footer {
    font-size: 80%;
    color: #666;
    border-top: 4px solid #eee;
    margin-top: 2em;
    overflow: hidden;
    .contact {
      float: left;
      margin-right: 3em;
      a {
        color: #8085C1;
      }
    }
    .rss {
      margin-top: 1.1em;
      margin-right: -.2em;
      float: right;
    }
    .rss img {
      border: 0;
    }
  }
}

// Posts
.post {
  pre {
    border: 1px solid #ddd;
    background-color: #eef;
    padding: 0 .4em;
    code {
      border: none;
    }
    &.terminal {
      border: 1px solid #000;
      background-color: #333;
      color: #FFF;
      code {
        background-color: #333;
      }
    }
  }
  ul, ol {
    margin-left: 1.35em;
  }
  code {
    border: 1px solid #ddd;
    background-color: #eef;
    padding: 0 .2em;
  }
}
```

### CSS customization

Zaczynamy od kolorowania składni. Jeśli korzystamy z gemu Kramdown, to
blok kodu (w języku Ruby) wstawiamy w taki sposób:

    ~~~ruby
    def print_hi(name)
      puts "Hi, #{name}"
    end
    print_hi('Tom')
    #=> prints 'Hi, Tom' to STDOUT.
    ~~~

Musimy jeszcze wygenerować arkusz CSS i dodać go do
katalogu *css*:

```sh
coderay stylesheet > css/syntax.css
```

Pozostałe rzeczy do poprawy/wymiany:

1\. Litery są za małe (16px minimum)
Szerokość kolumny tekstu powinna zawierać 60-70 znaków.
Ile to będzie jednostek em? ile px?
Kolumnę dosunąć do lewego marginesu
i dodać *left-margin* 40px.<br>
Domyślny font to Helvetica/Arial. Są to fonty MS.
Wymienić na jakiś open source font.

Dodatkowe reguły CSS zapisujemy w plikuu *custom.less*:


```css
---
title: custom CSS
---

body {
  font: 18px/1.6 DejaVu Sans, Helvetica, Arial, sans-serif;
}

.site {
  position: relative;
  text-align: left;
  width: 660px;  // 42em
  margin: 40px auto 40px 40px;
}

.post {
  pre {
    border: 0;
    padding: 0.5em 1em;
  }
}

ul.posts {
  span {
    color: #aaa;
    font-family: "DejaVu Sans Mono", monospace;
    font-size: 80%;
  }
}

.CodeRay {
  border: 0;
  font-family: "DejaVu Sans Mono", monospace;
}

// quotes
blockquote {
  position: absolute;
  left: 100%;
  margin-left: 20px;
  border: 1px solid #ddd;
  width: 300px;
  padding: 0 20px;
  font: 14px/1.7 "DejaVu Serif", serif;
  .author {
    text-align: right;
    padding-right: 2em;
    font-style: italic;
  }
  img {
    display: block;
    max-width: 300px;
    margin: 0.5em auto 1em auto;
  }
}
```


## Instalacja na skróty

Oczywiście, będziemy potrzebować jakiegoś repozytorium na
serwerze [Github](https://github.com/) w którym utworzyliśmy,
tak jak to opisano powyżej w *Ćwiczeniu 1*, gałąź *gh-pages*.

W przykładzie poniżej nazwa repozytorium to ***abc***.
Zaczynamy od sklonowania rpozytorium. Po sklonowaniu,
zmieniamy katalog na katalog główny repozytorium:

```sh
git clone git@github.com:〈twój login na serwerze Github〉/abc.git
cd abc/
git pull
git checkout --track origin/gh-pages
git rm -f *
git add .
git commit -m "usunąłem wygenerowanego na Github bloga"
git push
git checkout master
```

Następnie dodajemy zdalne repozytorium *temp* do *jekyll-based-repository-pages*,
kopiujemy katalog *blog* z gałęzi *master* do lokalnego katalogu *blog*
i usuwamy, niepotrzebne już, *temp*:

```sh
git remote add -f temp git://github.com/wbzyl/jekyll-based-repository-pages # add&fetch
git read-tree --prefix=blog/ -u temp/master:blog
git remote rm temp
```

Zmieniamy za pomocą skryptu *fix-names.sh* wartość zmiennej *baseurl*
oraz ustawiamy nazwę naszego bloga:

```sh
cd blog
./fix-names.sh /abc 'Blogging ABC'
```

Zapisujemy info w logu repozytorium i przesyłamy zmiany na *github.com*:

```sh
cd ../
git add blog/
git commit -m "Wykonano read-tree z temp/master:blog/."
git push
```

Nadszedł najwyższy czas, żeby sprawdzić, czy blog działa lokalnie.
W tym celu uruchamiamy serwer www:

```sh
cd blog
jekyll serve -b /abc --watch  # http://localhost:4000/abc/
```

Jeśli blog działa, to spróbujemy go wdrożyć na serwerze Github.
Ale najpierw dodamy wszystkie zmiany do repozytorium:

```sh
git add .
git commit -m "Poprawki: dodano katalog _site do repo oraz wykonano skrypt fix-names.sh."
git push
```

Dopiero teraz, tak jak to opisano powyżej, zapisujemy zawartość
katalogu *_site* na gałęzi *gh-pages* i przenosimy ją do
repozytorium na serwerze Github:

```sh
cd ..                  # opuszczamy katalog blog/
git checkout gh-pages

git read-tree -m -u master:blog/_site/
git commit -m "Skopiowano zawartość katalogu blog/ z master do gh-pages"
git checkout master
```

Po chwili sprawdzamy pod takim URL, czy blog działa:

    http://〈nazwa użytkownika〉.github.io/〈nazwa repozytorium〉/
