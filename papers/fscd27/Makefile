# all sources needed to build the paper
SOURCES = $(wildcard *.tex *.cls *.sty *.bib)
# sources for the arxiv version
ARXIV_SOURCES = $(filter-out $(wildcard *types*),$(wildcard *.tex *.cls *.sty *.bib *.bbl) cc-by.pdf lipics-logo-bw.pdf orcid.pdf)
# sources for the camera-ready version
FSCD_SOURCES = fscd27-lists.tex $(filter-out $(wildcard *arxiv*)$(wildcard *types*),$(wildcard *.tex *.cls *.sty *.bib *.bbl))
# targets to build: full paper, and the stripped submission
TARGETS = fscd27-lists.pdf arxiv-lists.pdf
# latexmk setup
DEPS_DIR = .deps
ENGINE = -pdf
LATEXMK = latexmk -recorder -use-make $(ENGINE)
# helper programs
PDFTK = pdftk

all: $(TARGETS)

fscd27-lists.pdf: $(SOURCES)
	$(LATEXMK) fscd27-lists.tex

arxiv-lists.tex: fscd27-lists.tex
	cp -f $< $@ || true

arxiv-lists.pdf: $(SOURCES)
	$(LATEXMK) arxiv-lists.tex

cont: continuous
continuous: LATEXMK += -f -interaction=nonstopmode -pvc
continuous: $(SOURCES)
	$(LATEXMK) fscd27-lists.tex

arxiv.tar.gz:
	tar achvf arxiv.tar.gz $(ARXIV_SOURCES)

fscd27-lists.zip: $(SOURCES)
	zip fscd27-lists.zip $(FSCD_SOURCES)

deploy: all
	rsync -avchzP fscd27-lists.pdf vikraman@internal.vikraman.org:_site/files/

fast-deploy: LATEXMK += -f -interaction=nonstopmode
fast-deploy: deploy

cont-deploy: continuous-deploy
continuous-deploy: $(SOURCES)
	watchman-make -p '**/*.tex' '**/*.bib' '**/*.cls' '**/*.sty' -t fast-deploy

clean:
	latexmk -c

distclean: clean
	latexmk -C
	rm -rf *.axp *.xcp *.bbl *.blg *.aux *.xml *.cut *.pdf

cache-clean:
	rm -rf `biber --cache`

.PHONY: clean distclean cache-clean cont continuous fast-continuous deploy fast-deploy cont-deploy continuous-deploy
