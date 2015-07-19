project=thesis
FILES = $(wildcard *.tex) db.bib
latexopts = -file-line-error

pdf: $(FILES)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)
	bibtex $(project)
	bibtex $(project)
	bibtex $(project)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)

view: pdf
	open $(project).pdf

clean:
	-rm -rf *.out $(project).pdf *.aux *.bbl *.blg *.log *.toc 2> /dev/null

edit:
	vim $(FILES) -p
	clear
	grep --colour=always TODO $(FILES)

file:
	vim Makefile
