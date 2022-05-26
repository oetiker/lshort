#	pstops "4:0L@0.8(22.5cm,-0.6cm)+1L@0.8(22.5cm,13.3cm),2L@0.8(22.5cm,-0.6cm)+3L@0.8(22.5cm,13.3cm)" \
SHELL = /bin/sh
VERS = 7.0

OTHER = README CHANGES

FILES ::= $(shell find -L src -type f \( -name "*.tex" -o -name "*.bib" -o -name "*.sty" \)  -print) src/title.tex

# Define some variables
OUTPUT_DIR=pdfbuild
PDFLATEX=lualatex --shell-escape --interaction=nonstopmode \
	--output-directory=$(OUTPUT_DIR) --halt-on-error
BIBER=biber --input-directory=src --output-directory=$(OUTPUT_DIR)
PDFLATEX_DEBUG_ARGS=--synctex=1 --file-line-error
MAKEINDEX=makeindex

.PHONY: quick all lulu

# The default targets
all: lshort.pdf lshort-letter.pdf lshort-a5.pdf

lulu: lshort-body.pdf lshort-title.pdf

export TEXINPUTS::=src:src/examples:$(OUTPUT_DIR):$(TEXINPUTS)

%.pdf: $(FILES) $(OUTPUT_DIR)
	$(PDFLATEX) $(basename $@)
	$(PDFLATEX) $(basename $@)
	$(MAKEINDEX) -s src/lshort.ist $(OUTPUT_DIR)/$(basename $@)
	$(BIBER) $(basename $@)
	$(PDFLATEX) $(basename $@)
	$(PDFLATEX) $(basename $@)
	mv $(OUTPUT_DIR)/$@ .

$(OUTPUT_DIR): src/lshort.bib
	mkdir -p $(OUTPUT_DIR)
	cp src/lshort.bib $(OUTPUT_DIR)/

src/title.tex: Makefile fixdate.pl src/title.template.tex
	perl fixdate.pl $(VERS) $(GITHUB_SHA) < src/title.template.tex > src/title.tex

quick: $(FILES) $(OUTPUT_DIR)
	$(PDFLATEX) $(PDFLATEX_DEBUG_ARGS) lshort


tar:	$(FILES)
	ln -s . lshort-$(VERS)
	tar -zcvf lshort-$(VERS).src.tar.gz `awk '{print "lshort-$(VERS)/"$$1}' MANIFEST`
	rm lshort-$(VERS)

rsync:  all tar
	echo press enter to rsync
	read x
	rsync  lshort-$(VERS).src.tar.gz CHANGES README lshort.pdf lshort-letter.pdf lshort-a5.pdf freddie:public_html/latex/

dist:   rsync
	-rm lshort-english
	ln -s . lshort-english
	zip lshort-$(VERS).zip lshort-english/lshort-$(VERS).src.tar.gz lshort-english/CHANGES lshort-english/README lshort-english/lshort.pdf lshort-english/lshort-letter.pdf lshort-english/lshort-a5.pdf
	-rm lshort-english
	echo upload lshort-$(VERS).zip to https://ctan.org/pkg/lshort-english

clean:
	rm -rf $(OUTPUT_DIR)
