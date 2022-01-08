# (The MIT License)
#
# Copyright (c) 2021-2022 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

.SHELLFLAGS = -e -x -c
.ONESHELL:

all: clicks.pdf test copyright zip

copyright:
	grep -q -r "2021-$$(date +%Y)" --include '*.tex' --include '*.sty' --include 'Makefile' .

test:
	pdflatex test.tex

clicks.pdf: clicks.tex clicks.sty
	latexmk -pdf $<
	texsc $<
	texqc --ignore 'You have requested document class' $<

zip: clicks.pdf clicks.sty
	rm -rf package
	mkdir package
	cd package
	mkdir clicks
	cd clicks
	cp ../../README.md .
	version=$$(curl --silent -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/yegor256/clicks/releases/latest | jq -r '.tag_name')
	echo "Version is: $${version}"
	date=$$(date +%Y/%m/%d)
	echo "Date is: $${date}"
	cp ../../clicks.sty .
	gsed -i "s|0\.0\.0|$${version}|" clicks.sty
	gsed -i "s|00\.00\.0000|$${date}|" clicks.sty
	cp ../../clicks.tex .
	gsed -i "s|0\.0\.0|$${version}|" clicks.tex
	gsed -i "s|00\.00\.0000|$${date}|" clicks.tex
	cp ../../.latexmkrc .
	latexmk -pdf clicks.tex
	rm .latexmkrc
	rm -rf _minted-* *.clicks *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.out *.exc
	cat clicks.sty | grep RequirePackage | gsed -e "s/.*{\(.\+\)}.*/hard \1/" > DEPENDS.txt
	cd ..
	zip -r clicks.zip *
	cp clicks.zip ../clicks-$${version}.zip
	cd ..

clean:
	git clean -dfX
