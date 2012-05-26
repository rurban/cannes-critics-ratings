#!/bin/sh
c="Cannes 2012 - Películas%2FFilms.csv"
# http://stackoverflow.com/questions/3287651/download-a-spreadsheet-from-google-docs-using-python
# if [ -f csvdownload.py ]; then ./csvdownload.py > ~/Downloads/"$c"; fi
diff -bu "$c" ~/Downloads/"$c" || \
  (mv "$c" "$c.bak"; mv ~/Downloads/"$c" "$c"; ./csvsplit.pl > xx)
