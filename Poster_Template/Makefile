all:
	@pdflatex -draftmode -interaction=nonstopmode -file-line-error -shell-escape poster.tex
	#@bibtex poster.aux
	@pdflatex -draftmode -interaction=nonstopmode -file-line-error -shell-escape poster.tex
	pdflatex -interaction=nonstopmode -file-line-error --shell-escape poster.tex
	@rm -rf *.aux *.bbl *.blg *.idx *.lof *.log *.lot *.out *.toc *.ist *.gls *.glo *.glg *.pyg *.bcf
	gs -dSAFER -dBATCH -dNOPAUSE  -sDEVICE=pdfwrite -sOutputFile=PosterA0WIN.pdf poster.pdf
