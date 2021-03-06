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

fv: full view

$(project).bbl: db.bib
	bibtex $(project)
	bibtex $(project)
	bibtex $(project)

bibtex: $(project).bbl

%.aux: %.tex
	pdflatex $(latexopts) $(project)

$(project).pdf: $(texfiles)
	pdflatex $(latexopts) $(project)

twice: $(project).pdf
	pdflatex $(latexopts) $(project)

thrice: twice
	pdflatex $(latexopts) $(project)

view: twice
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
	@echo "number of TODOs: "
	@grep --colour=always TODO $(files) | wc -l

file:
	vim Makefile

.PHONY: $(project).pdf view file edit clean cleanpdf cleanfiles full pdflatex bibtex twice thrice
