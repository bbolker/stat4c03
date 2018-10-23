SRCDIR=..

admin += outline schedule
pdfnotes += intro distribs contrasts glm_deriv glm_comp inference logistic binomial_poisson separation
htmlnotes += modeling_inference
rmdnotes += intro distribs modeling_inference
rnwnotes += contrasts glm_deriv glm_comp inference logistic binomial_poisson separation
hw += hw1 hw2 hw1_comments hw3 hw3_sol

adminhtml := $(admin:%=Admin/%.html)
nnrmd := $(rmdnotes:%=notes/%.rmd)
nnrnw := $(rnwnotes:%=notes/%.rnw)
nnpdf := $(pdfnotes:%=notes/%.pdf)
nnhtml := $(htmlnotes:%=notes/%.html)
hwhtml := $(hw:%=HW/%.html)

## OLD stuff from Morelia
## modeling_inference glmm datavis bayes bayeslab mixed_details mixedlab glmm_details glmmlab addons

## Datasets += aids.csv  Banta.RData  gopherdat2.csv culcitalogreg.csv gopherdat2.RData starling.RData culcita.RData gophertortoise.txt toenail.csv dufemalepers.csv tundra.csv Elston2001_tickdata.txt lizards.csv tundra_agg.rda

## dd := $(Datasets:%=data/%)
## rr := $(Rfiles:%=R/%)

all: ${adminhtml} ${nnrmd} ${nnrnw} ${nnpdf} ${nnhtml} ${hwhtml}

Admin/%.html: ${SRCDIR}/Admin/%.rmd
	echo "rmarkdown::render(\"$<\",output_format='html_document',output_dir='Admin')" | R --slave

Admin/schedule.html: ${SRCDIR}/Admin/schedule.csv ${SRCDIR}/Admin/schedule.rmd

### OLD

notes/%.rmd:  ${SRCDIR}/notes/%.[Rr]md
	cp $< $@

notes/%.rnw:  ${SRCDIR}/notes/%.[Rr]nw
	cp $< $@

R/%.R:  ${SRCDIR}/R/%.R
	cp $< $@

%.html: ${SRCDIR}/%.[Rr]md
	echo "rmarkdown::render(\"$<\",output_dir='.')" | R --slave

%.pdf: ${SRCDIR}/%.rmd
	echo "rmarkdown::render(\"$<\",output_dir='.',output_format=\"pdf_document\")" | R --slave

notes/%.slides.html: ${SRCDIR}/notes/%.rmd
	echo "rmarkdown::render(\"$<\",,output_file=\"$@\",output_format='ioslides_presentation',output_dir='notes')" | R --slave

notes/%.html: ${SRCDIR}/notes/%.rmd
	echo "rmarkdown::render(\"$<\",output_format='html_document',output_dir='notes')" | R --slave

HW/%.html: ${SRCDIR}/HW/%.rmd
	echo "rmarkdown::render(\"$<\",output_format='html_document',output_dir='HW')" | R --slave

notes/%.pdf: ${SRCDIR}/notes/%.rmd
	echo "rmarkdown::render(\"$<\",output_format='tufte_handout',output_dir='notes')" | R --slave

notes/%.pdf: ${SRCDIR}/notes/%.rnw
	echo "knitr::knit2pdf(\"$<\",output=\"$*.tex\")" | R --slave; mv $*.pdf notes/$*.pdf

##notes/%.tex: ${SRCDIR}/notes/%.rnw
##	echo "knitr::knit(\"$<\",output=\"$*.tex\")" | R --slave; mv $*.tex notes/$*.tex

glmm_data.zip: 
	cd ..; zip gh-pages/glmm_data.zip ${dd}

%.clean:
	rm -f $*.out $*.log $*.aux $*-tikzDictionary $*.tex
