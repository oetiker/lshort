#	pstops "4:0L@0.8(22.5cm,-0.6cm)+1L@0.8(22.5cm,13.3cm),2L@0.8(22.5cm,-0.6cm)+3L@0.8(22.5cm,13.3cm)" \
SHELL = /bin/sh
VERS = 6.4

OTHER = README CHANGES

FILES ::= $(shell find -L src -type f \( -name "*.tex" -o -name "*.bib" -o -name "*.sty" \)  -print) src/title.tex

# Define some variables
LATEX=latex
PDFLATEX=xelatex --enable-write18
MAKEINDEX=makeindex
DVIPS=dvips

.PHONY: quick all lulu

# The default targets
all: lshort.pdf lshort-letter.pdf lshort-a5.pdf

lulu: lshort-body.pdf lshort-title.pdf

%.pdf: $(FILES)
	-mkdir pdfbuild
	(TEXINPUTS=.:`pwd`/src:${TEXINPUTS:-:}&&export TEXINPUTS&& cp src/biblio.bib pdfbuild/ && cd pdfbuild &&\
	$(PDFLATEX) $(basename $@)&& $(PDFLATEX) $(basename $@)&& \
	$(MAKEINDEX) -s ../src/lshort.ist $(basename $@) && biber $(basename $@) &&$(PDFLATEX) $(basename $@)&& \
	(thumbpdf --resolution 10 $@ && $(PDFLATEX) $(basename $@))&& \
	mv $@ .. )

src/title.tex: Makefile fixdate.pl src/title.template.tex
	perl fixdate.pl $(VERS) < src/title.template.tex > src/title.tex

quick: $(FILES)
	-mkdir pdfbuild
	(TEXINPUTS=.:`pwd`/src:${TEXINPUTS:-:}&&export TEXINPUTS && cd pdfbuild &&\
	$(PDFLATEX) lshort && mv lshort.pdf .. )


tar:	$(FILES)
	ln -s . lshort-$(VERS)
	tar -zcvf lshort-$(VERS).src.tar.gz `awk '{print "lshort-$(VERS)/"$$1}' MANIFEST`
	rm lshort-$(VERS)

rsync:  all tar
	echo press enter to rsync
	read x
	rsync  lshort-$(VERS).src.tar.gz CHANGES README lshort.pdf lshort-letter.pdf lshort-a5.pdf james:public_html/latex/

dist:   rsync
	-rm lshort-english
	ln -s . lshort-english
	zip lshort-$(VERS).zip lshort-english/lshort-$(VERS).src.tar.gz lshort-english/CHANGES lshort-english/README lshort-english/lshort.pdf lshort-english/lshort-letter.pdf lshort-english/lshort-a5.pdf
	-rm lshort-english
	echo upload lshort-$(VERS).zip to http://www.ctan.org/upload

clean:
	rm -rf texbuild pdfbuild
