#	pstops "4:0L@0.8(22.5cm,-0.6cm)+1L@0.8(22.5cm,13.3cm),2L@0.8(22.5cm,-0.6cm)+3L@0.8(22.5cm,13.3cm)" \
SHELL = /bin/sh
VERS = 5.06

OTHER = README CHANGES
FILES = src/biblio.tex src/math.tex src/things.tex src/contrib.tex src/lshort.sty src/mylayout.sty src/title.tex \
	src/custom.tex src/lshort.tex src/overview.tex src/typeset.tex src/fancyhea.sty src/lssym.tex src/spec.tex \
	src/lshort-base.tex src/lshort-letter.tex src/lshort-a5.tex src/graphic.tex src/appendix.tex

# Define some variables
LATEX=latex
PDFLATEX=pdflatex
MAKEINDEX=makeindex
DVIPS=dvips

# The default targets
all: lshort.pdf lshort-letter.pdf lshort-a5.pdf

lulu: lshort-body.pdf lshort-title.pdf


lshort.dvi: $(FILES)
	-mkdir texbuild
	(TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:} && export TEXINPUTS && cd texbuild && \
	$(LATEX) lshort && $(LATEX) lshort && $(MAKEINDEX) -s ../src/lshort.ist lshort; \
	$(LATEX) lshort && $(LATEX) lshort && mv lshort.dvi ..)

lshort-a5.dvi: $(FILES)
	-mkdir texbuild
	(TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:} && export TEXINPUTS && cd texbuild && \
	$(LATEX) lshort-a5 && $(LATEX) lshort-a5 && $(MAKEINDEX) -s ../src/lshort.ist lshort-a5; \
	$(LATEX) lshort-a5 && $(LATEX) lshort-a5 && mv lshort-a5.dvi ..)

lshort.ps: lshort.dvi
	(T1FONTS=.: && TEXFONTMAPS=.: && export T1FONTS TEXFONTMAPS && $(DVIPS) -j -Pcmz -olshort.ps lshort.dvi )
	rm texbuild/*

lshort-a5.ps: lshort-a5.dvi
	(T1FONTS=.: && TEXFONTMAPS=.: && export T1FONTS TEXFONTMAPS  && $(DVIPS) -j -Pcmz -ta5 -olshort-a5.ps lshort-a5.dvi )
	rm texbuild/*

lshort-book.ps: lshort.ps
	psbook lshort.ps out.ps 
	pstops "4:0L@0.8(22.76cm,-0.6cm)+1L@0.8(22.76cm,13.45cm),3R@0.8(-1.38cm,16.25cm)+2R@0.8(-1.38cm,30.3cm)" \
			out.ps lshort-book.ps
	rm out.ps

lshort-a5book.ps: lshort-a5.ps
	( psbook lshort-a5.ps | psnup -pa4 -s1 -2 | pstops "2:0,1U(21cm,29.7cm)" >lshort-a5book.ps )

lshort-a5book.pdf: lshort-a5book.ps
	 ps2pdf14 -sPAPERSIZE=a4 lshort-a5book.ps lshort-a5book.pdf

lshort.pdf: $(FILES)
	-mkdir pdfbuild
	(T1FONTS=.:`pwd`/eurofont: && export T1FONTS && TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:}&&export TEXINPUTS&& cd pdfbuild&& \
	$(PDFLATEX) lshort&& $(PDFLATEX) lshort&& \
	$(MAKEINDEX) -s ../src/lshort.ist lshort&&$(PDFLATEX) lshort&& \
	(thumbpdf --resolution 10 lshort.pdf && $(PDFLATEX) lshort)&& \
	mv lshort.pdf .. )
	rm pdfbuild/*

lshort-body.pdf: $(FILES)
	-mkdir pdfbuild
	(T1FONTS=.:`pwd`/eurofont: && export T1FONTS && TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:}&&export TEXINPUTS&& cd pdfbuild&& \
	$(PDFLATEX) lshort-body && $(PDFLATEX) lshort-body && \
	$(MAKEINDEX) -s ../src/lshort.ist lshort-body &&$(PDFLATEX) lshort-body&& \
	mv lshort-body.pdf .. )
	rm pdfbuild/*

lshort-title.pdf: $(FILES)
	-mkdir pdfbuild
	(T1FONTS=.:`pwd`/eurofont: && export T1FONTS && TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:}&&export TEXINPUTS&& cd pdfbuild&& \
	$(PDFLATEX) lshort-title && $(PDFLATEX) lshort-title && \
	mv lshort-title.pdf .. )
	rm pdfbuild/*

lshort-a5.pdf: $(FILES)
	-mkdir pdfbuild
	(T1FONTS=.:`pwd`/eurofont: && export T1FONTS && TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:}&&export TEXINPUTS&& cd pdfbuild&& \
	$(PDFLATEX) lshort-a5&& $(PDFLATEX) lshort-a5&& \
	$(MAKEINDEX) -s ../src/lshort.ist lshort-a5&&$(PDFLATEX) lshort-a5&& \
	(thumbpdf --resolution 10 lshort-a5.pdf && $(PDFLATEX) lshort-a5)&& \
	mv lshort-a5.pdf .. )
	rm pdfbuild/*

lshort-letter.pdf: $(FILES)
	-mkdir pdfbuild
	(T1FONTS=.:`pwd`/eurofont: && export T1FONTS && TEXINPUTS=.:`pwd`/src:`pwd`/euro:`pwd`/oberdiek:${TEXINPUTS:-:}&&export TEXINPUTS&& cd pdfbuild&& \
	$(PDFLATEX) lshort-letter&& $(PDFLATEX) lshort-letter&& \
	$(MAKEINDEX) -s ../src/lshort.ist lshort-letter&&$(PDFLATEX) lshort-letter&& \
	(thumbpdf --resolution 10 lshort-letter.pdf && $(PDFLATEX) lshort-letter)&& \
	mv lshort-letter.pdf .. )
	rm pdfbuild/*

src/title.tex: Makefile fixdate.pl
	perl fixdate.pl $(VERS) < src/title.tex > src/title.tex2 && mv src/title.tex2 src/title.tex

quick: $(FILES)
	(TEXINPUTS=`pwd`/src:$(TEXINPUTS)&& export TEXINPUTS&& cd texbuild&& \
        $(LATEX) lshort&& mv lshort.dvi ..)


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
