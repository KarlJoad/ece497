$latex = 'latex -interaction=nonstopmode -shell-escape';
$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape';

$pdf_mode = 1; # tex -> pdf
$pdf_previewer = 'start xdg-open'; # Use xdg-open to open the output PDF

@default_files = ('doc.tex') # The doc.tex file is the root file for this document
