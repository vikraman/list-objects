# all sources needed to build the papers
SOURCES = $(wildcard *.sty *.bib)
# sources for the arxiv version
ARXIV_SOURCES = arxiv-lists.tex arxiv-lists.bbl $(wildcard *.sty)
# latexmk setup
ENGINE = -pdf
LATEXMK = latexmk -recorder -use-make $(ENGINE)

all: msfp26-lists.pdf arxiv-lists.pdf

msfp26-lists.pdf: msfp26-lists.tex $(SOURCES)
	$(LATEXMK) msfp26-lists.tex

arxiv-lists.pdf: arxiv-lists.tex $(SOURCES)
	$(LATEXMK) arxiv-lists.tex

arxiv-lists.bbl: arxiv-lists.pdf

arxiv.tar.gz: arxiv-lists.bbl
	tar achvf arxiv.tar.gz $(ARXIV_SOURCES)

clean:
	latexmk -c

distclean: clean
	latexmk -C
	rm -rf *.axp *.bbl *.blg *.aux *.xml arxiv.tar.gz

.PHONY: all clean distclean
