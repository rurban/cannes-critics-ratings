#!/bin/sh
c="Cannes 2012 - Películas%2FFilms.csv"
diff -bu ~/Downloads/"$c" "$c" || (mv ~/Downloads/"$c" "$c"; ./csvsplit.pl > xx)
