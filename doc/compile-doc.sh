#!/usr/bin/env bash

pdflatex --synctex=1 -interaction=nonstopmode -shell-escape doc.tex

biber doc

makeglossaries doc
biber doc
makeglossaries doc
# makeindex -s "doc.ist" -t "doc.alg" -o "doc.acr" "doc.acn"

pdflatex --synctex=1 -interaction=nonstopmode -shell-escape doc.tex
biber doc

pdflatex --synctex=1 -interaction=nonstopmode -shell-escape doc.tex
pdflatex --synctex=1 -interaction=nonstopmode -shell-escape doc.tex
