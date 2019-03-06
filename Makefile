all:	html docx

html:
	pandoc --standalone -c style.css --from markdown --to html -o alexc.html index.md alexc.md

docx:
	pandoc --from markdown --to docx -o alexc.docx index.md alexc.md
