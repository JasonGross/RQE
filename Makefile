.PHONY: all
TOP_PDFS := cover.pdf abstract.pdf with-cover.pdf
all: rewriting/rewriting.pdf $(TOP_PDFS)

rewriting/%.pdf:
	$(MAKE) -C rewriting $*.pdf

only-abstract.tex: rewriting/rewriting.tex
	cat $< | grep -A 10000 '\\begin{abstract}' | grep -B 10000 '\\end{abstract}' > $@

abstract.pdf: only-abstract.tex

with-cover.pdf: rewriting/rewriting.pdf cover.pdf

$(TOP_PDFS) : %.pdf : %.tex
	$(MAKE) -f Makefile.common $@
