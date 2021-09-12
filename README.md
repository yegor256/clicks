[![make](https://github.com/yegor256/clicks/actions/workflows/latexmk.yml/badge.svg)](https://github.com/yegor256/clicks/actions/workflows/latexmk.yml)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yegor256/clicks/blob/master/LICENSE.txt)

This LaTeX package simulates animiation in slide deck, similar to what PowerPoint can do.

First, [install it](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages)
from [CTAN](https://ctan.org/pkg/clicks) 
and then use in the preamble:

```tex
\documentclass{article}
\usepackage{clicks}
\begin{document}
\plick{Here is your wedding plan:}
\plick{1. Buy a ring}
\plick{2. Propose}
\plush{3. Get married}
And then live happily ever after.
\end{document}
```

The full example and all commands are available in the 
[`clicks.tex`](https://github.com/yegor256/clicks/blob/master/clicks.tex) file.

If you want to contribute yourself, make a fork, then create a branch, 
then run `make` in the root directory.
It should compile everything without errors. If not, submit an issue and wait.
Otherwise, make your changes and then run `make` again. If the build is
still clean, submit a pull request.
