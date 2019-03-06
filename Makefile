all:	html docx pdf

format:
	perl -p -e 's/(^)(\* )(.*).\n/\3, /g;' index.md | perl -p -e 's/, \n/\n\n/g;' > format.md

html: format
	pandoc --standalone -c style.css --from markdown --to html -o alexc.html format.md alexc.md

docx: format
	pandoc --from markdown --to docx -o alexc.docx format.md alexc.md

pdf: format
	pandoc -t html5 --css style.css -o alexc.pdf format.md alexc.md

