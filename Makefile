SRCDIR=..


admin += outline schedule
rmdnotes += intro distribs ## modeling_inference glmm datavis bayes bayeslab mixed_details mixedlab glmm_details glmmlab addons
## rmdnotes
rmdpdf += intro ## modeling_inference glmm datavis bayes bayeslab mixed_details mixedlab glmm_details glmmlab addons

adminhtml := $(admin:%=Admin/%.html)
nnrmd := $(rmdnotes:%=notes/%.rmd)
nnpdf := $(rmdnotes:%=notes/%.pdf)

## nnslides := notes/glmm.slides.html #$(notes:%=notes/%.slides.html)

## Datasets += aids.csv  Banta.RData  gopherdat2.csv culcitalogreg.csv gopherdat2.RData starling.RData culcita.RData gophertortoise.txt toenail.csv dufemalepers.csv tundra.csv Elston2001_tickdata.txt lizards.csv tundra_agg.rda

## Rfiles += lunes.R martes.R miércoles.R geom_cstar.R calcDenDF.R allFit.R

## dd := $(Datasets:%=data/%)
## rr := $(Rfiles:%=R/%)

all: ${adminhtml} ${nnrmd} ${nnpdf}

Admin/%.html: ${SRCDIR}/Admin/%.rmd
	echo "rmarkdown::render(\"$<\",output_format='html_document',output_dir='Admin')" | R --slave

Admin/schedule.html: ${SRCDIR}/Admin/schedule.csv ${SRCDIR}/Admin/schedule.rmd

### OLD

notes/%.rmd:  ${SRCDIR}/notes/%.[Rr]md
	cp $< $@

R/%.R:  ${SRCDIR}/R/%.R
	cp $< $@

%.html: ${SRCDIR}/%.[Rr]md
	echo "rmarkdown::render(\"$<\",output_dir='.')" | R --slave

%.pdf: ${SRCDIR}/%.rmd
	echo "rmarkdown::render(\"$<\",output_dir='.',output_format=\"pdf_document\")" | R --slave


notes/%.slides.html: ${SRCDIR}/notes/%.rmd
	echo "rmarkdown::render(\"$<\",,output_file=\"$@\",output_format='ioslides_presentation',output_dir='notes')" | R --slave

notes/%.pdf: ${SRCDIR}/notes/%.rmd
	echo "rmarkdown::render(\"$<\",output_format='tufte_handout',output_dir='notes')" | R --slave

glmm_data.zip: 
	cd ..; zip gh-pages/glmm_data.zip ${dd}

