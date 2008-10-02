#	pstops "4:0L@0.8(22.5cm,-0.6cm)+1L@0.8(22.5cm,13.3cm),2L@0.8(22.5cm,-0.6cm)+3L@0.8(22.5cm,13.3cm)" \
SHELL = /bin/sh
VERS = 4.26

OTHER = README CHANGES
FILES = src/biblio.tex src/math.tex src/things.tex src/contrib.tex src/lshort.sty src/mylayout.sty src/title.tex \
	src/custom.tex src/lshort.tex src/overview.tex src/typeset.tex src/fancyhea.sty src/lssym.tex src/spec.tex \
	src/lshort-base.tex src/lshort-a5.tex src/graphic.tex

# Define some variables
LATEX=latex
PDFLATEX=pdflatex
MAKEINDEX=makeindex
DVIPS=dvips

# The default targets
all: lshort.ps lshort-book.ps lshort.pdf lshort-a5book.pdf


lshort.dvi: $(FILES)
	-mkdir texbuild
	(TEXINPUTS=.:`pwd`/src:`pwd`/euro:${TEXINPUTS:-:} && export TEXINPUTS && cd texbuild && \
	$(LATEX) lshort && $(LATEX) lshort && $(MAKEINDEX) -s ../src/lshort.ist lshort; \
	$(LATEX) lshort && $(LATEX) lshort && mv lshort.dvi ..)

lshort-a5.dvi: $(FILES)
	-mkdir texbuild
	(TEXINPUTS=.:`pwd`/src:`pwd`/euro:${TEXINPUTS:-:} && export TEXINPUTS && cd texbuild && \
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
	(T1FONTS=.:`pwd`/eurofont: && export T1FONTS && TEXINPUTS=.:`pwd`/src:`pwd`/euro:${TEXINPUTS:-:}&&export TEXINPUTS&& cd pdfbuild&& \
	$(PDFLATEX) lshort&& $(PDFLATEX) lshort&& \
	$(MAKEINDEX) -s ../src/lshort.ist lshort&&$(PDFLATEX) lshort&& \
	(thumbpdf --resolution 10 lshort.pdf && $(PDFLATEX) lshort)&& \
	mv lshort.pdf .. )
	rm pdfbuild/*

src/title.tex: Makefile
	perl fixdate.pl $(VERS) < src/title.tex > src/title.tex2 && mv src/title.tex2 src/title.tex

quick: $(FILES)
	(TEXINPUTS=`pwd`/src:$(TEXINPUTS)&& export TEXINPUTS&& cd texbuild&& \
        $(LATEX) lshort&& mv lshort.dvi ..)


tar:	$(FILES)
	ln -s . lshort-$(VERS)
	tar -zcvf lshort-$(VERS).src.tar.gz `awk '{print "lshort-$(VERS)/"$$1}' MANIFEST`
	rm lshort-$(VERS)

dist:	all tar
	echo press enter to rsync
	read x
	rsync  lshort-$(VERS).src.tar.gz CHANGES README lshort.pdf lshort-a5book.pdf james:public_html/latex/
	lftp -e 'cd incoming;mkdir lshort-$(VERS);cd lshort-$(VERS);mput lshort-$(VERS).src.tar.gz CHANGES README lshort-book.ps lshort.dvi lshort.pdf lshort.ps;quit' ftp.tex.ac.uk
	(echo -e "Robin,\n\nI have uploaded lshort-$(VERS) to ftp.tex.ac.uk:/incoming/lshort-$(VERS).\n\nIf you think it is appropriate, announce it please.\n\nThanks and cheers\ntobi\n\n\n--";fortune -s shakes goethe) | mailx -s "Lshort Upload (note the quote)" ctan@dante.de
	(echo -e "Folks,\n\nI have created lshort-$(VERS). It is available from http://tobi.oetiker.ch/latex.\n\nCheers tobi\n\n\n--";fortune -s shakes goethe) | mailx -s "Lshort $(VERS)" `cat TRLIST`

clean:
	rm -rf texbuild pdfbuild
