RM=rm -f
TEX=pdflatex -interaction=nonstopmode
BIBTEX=bibtex
BIB=references.bib

TEX_DIR=tex/
VERB_DIR=verb/
MAIN=RePhorm2

.PHONY: clean veryclean

default:
# Failing due to bib problems -- KH	
#	latexmk -pdf  $(MAIN).tex
	pdflatex $(MAIN).tex
	-bibtex
	-pdflatex $(MAIN).tex
	-pdflatex $(MAIN).tex

watch:
	latexmk -pdf -pvc $(MAIN).tex

final: ${MAIN}.pdf ${SOURCES}
	-mkdir final
	-cp split.sh final/
	-pdflatex -output-directory final "\\def\\final{}\\input{${MAIN}}"
	-cd final; sh ./split.sh

#cleaning rules

clean:
	$(RM) *.aux *.xml *.bcf *.bbl *.blg *-blx.bib \
		*.log *.nav *.out *.vrb *.snm *.toc \
		X.tex *.bak *.pag *.fdb_latexmk *.fls \
		*.brf

veryclean: clean
	$(RM) *.pdf *.dvi

