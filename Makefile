.PHONY: all
TOP_NORMAL_PDFS := cover.pdf abstract.pdf
TOP_PDFS := $(TOP_NORMAL_PDFS) rewriting-with-cover.pdf
all: rewriting/rewriting.pdf $(TOP_PDFS)

rewriting/%.pdf:
	$(MAKE) -C rewriting $*.pdf

only-abstract.tex: rewriting/rewriting.tex
	cat $< | grep -A 10000 '\\begin{abstract}' | grep -B 10000 '\\end{abstract}' > $@

abstract.pdf: only-abstract.tex

rewriting-with-cover.pdf: cover.pdf rewriting/rewriting.pdf
	pdftk cover.pdf rewriting/rewriting.pdf cat output $@

$(TOP_NORMAL_PDFS) : %.pdf : %.tex
	$(MAKE) -f Makefile.common $@
