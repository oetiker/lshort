# Copyright (C) 2022 Tobias Oetiker, Marcin Serwin
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

VERSION = 7.0

OTHER = README CHANGES

FILES ::= $(shell find -L src -type f \( -name "*.tex" -o -name "*.bib" -o -name "*.sty" \)  -print) src/title.tex

# Define some variables
OUTPUT_DIR=pdfbuild
PDFLATEX=lualatex --shell-escape --interaction=nonstopmode \
	--output-directory=$(OUTPUT_DIR) --halt-on-error
BIBER=biber --input-directory=src --output-directory=$(OUTPUT_DIR)
PDFLATEX_DEBUG_ARGS=--synctex=1 --file-line-error
MAKEINDEX=makeindex -s src/lshort.ist 

export TEXINPUTS::=src:src/examples:$(OUTPUT_DIR):$(TEXINPUTS)
export VERSION
export GITHUB_SHA

.PHONY: quick all lulu indent clean

# The default targets
all: lshort.pdf lshort-letter.pdf lshort-a5.pdf

indent:
	latexindent -w -m -l .localSettings.yaml src/*.tex

%.pdf: $(FILES) $(OUTPUT_DIR)
	$(PDFLATEX) $(basename $@)
	$(PDFLATEX) $(basename $@)
	$(MAKEINDEX) $(OUTPUT_DIR)/$(basename $@)
	$(BIBER) $(basename $@)
	$(PDFLATEX) $(basename $@)
	$(PDFLATEX) $(basename $@)
	mv $(OUTPUT_DIR)/$@ .

$(OUTPUT_DIR): src/lshort.bib
	mkdir -p $(OUTPUT_DIR)
	cp src/lshort.bib $(OUTPUT_DIR)/

quick: $(FILES) $(OUTPUT_DIR)
	$(PDFLATEX) $(PDFLATEX_DEBUG_ARGS) lshort


tar: $(FILES)
	ln -s . lshort-$(VERSION)
	tar -zcvf lshort-$(VERSION).src.tar.gz `awk '{print "lshort-$(VERSION)/"$$1}' MANIFEST`
	rm lshort-$(VERSION)

rsync: all tar
	echo press enter to rsync
	read x
	rsync  lshort-$(VERSION).src.tar.gz CHANGES README lshort.pdf lshort-letter.pdf lshort-a5.pdf freddie:public_html/latex/

dist: rsync
	-rm lshort-english
	ln -s . lshort-english
	zip lshort-$(VERSION).zip lshort-english/lshort-$(VERSION).src.tar.gz lshort-english/CHANGES lshort-english/README lshort-english/lshort.pdf lshort-english/lshort-letter.pdf lshort-english/lshort-a5.pdf
	-rm lshort-english
	echo upload lshort-$(VERSION).zip to https://ctan.org/pkg/lshort-english

clean:
	rm -rf $(OUTPUT_DIR)
