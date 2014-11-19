all: Cannes2012.sorted.html Cannes2011.sorted.html Cannes2010.sorted.html


Cannes2012.sorted.html : Cannes2012.txt
	perl Cannes2012.txt > Cannes2012.sorted.html
	scp -q -P 3000 Cannes2012.txt Cannes2012.sorted.html rurban.xarch.at:film/

Cannes2011.sorted.html : Cannes2011.txt
	perl Cannes2011.txt > Cannes2011.sorted.html
	scp -q -P 3000 Cannes2011.txt Cannes2011.sorted.html rurban.xarch.at:film/

Cannes2010.sorted.html : Cannes2010.txt
	perl Cannes2010.txt > Cannes2010.sorted.html
	scp -q -P 3000 Cannes2010.txt Cannes2010.sorted.html rurban.xarch.at:film/
