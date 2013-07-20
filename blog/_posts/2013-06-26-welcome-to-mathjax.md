---
layout: post
title:  "Welcome to MathJax!"
date:   2013-06-26 16:16:16
categories: jekyll kramdown latex math
---

TeX + MathJax examples.

<blockquote>
 <img src="{{ site.baseurl }}/images/davide_cervone.jpg" alt="Davide Cervone">
<p>
  Finally, you are going to have to do more work to protect the
  mathematics from the Markdown engine so that things like underscores
  and backslashes don’t get processed by Markdown when they appear in
  mathematics. That is a bit tricky, but without that, you will run into
  lots of problems with your TeX code not getting processed properly.
</p>
<p class="author">— Davide Cervone</p>
</blockquote>

### Inline Math

Let $\alpha$ be the fifth root of unity.
We then want to evaluate the expression
$\log|1+\alpha+\alpha^2+\alpha^3−1/\alpha|$.

If $p=\frac{4\sinθ\cosθ}{\sinθ+\cosθ}$, find the value of
$\frac{p+2\sinθ}{p−2\sinθ} + \frac{p+2\cosθ}{p−2\cosθ}$.


### Display Math

$$A = \left[\matrix{1&2&3\cr4&5&6\cr7&8&9\cr}\right]
$$

Define function `print_hi`:

~~~ruby
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
~~~

$$\{\underbrace{\overbrace{\mathstrut a,\ldots,a}^{k\;a'\rm s},
  \overbrace{\mathstrut b,\ldots,b}^{l\;b'\rm s}\>}_{k+1\rm\;elements}\}
$$

$$\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+\sqrt{1+x}}}}}}}
$$

$$\delta\colon {\Bbb R}^3 \to {\Bbb R}
$$

$$M = \pmatrix{\pmatrix{a&b\cr c&d} & \pmatrix{e&f\cr g&h}\cr
  \bbox[#B2D1E5,1em]{\bf 0}&\pmatrix{i&j\cr k&l}}
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
na wzór i klikamy go prawym przyciskiem.
