project=thesis
texfiles = $(wildcard *.tex)
auxfiles = $(texfiles:.tex=.aux)
files = $(texfiles) db.bib
latexopts = -file-line-error

default: view

full: clean
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)
	bibtex $(project)
	bibtex $(project)
	bibtex $(project)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)
	pdflatex $(latexopts) $(project)

%.aux: %.tex
	pdflatex $(latexopts) $(project)

$(project).pdf: $(texfiles)
	pdflatex $(latexopts) $(project)

view: $(project).pdf
	open $(project).pdf

cleanpdf:
	-rm -rf $(project).pdf 2> /dev/null

cleanfiles:
	-rm -rf *.out $(project).pdf *.aux *.bbl *.blg *.log *.toc 2> /dev/null

clean: cleanpdf cleanfiles

edit:
	vim $(files) -p
	clear
	grep --colour=always TODO $(files)

file:
	vim Makefile

.PHONY: $(project).pdf view file edit clean cleanpdf cleanfiles full
