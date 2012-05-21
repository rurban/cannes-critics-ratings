#!/bin/sh
perl Cannes2012.txt |tee Cannes2012.sorted.html
f="Cannes2012.txt Cannes2012.sorted.html"
git add $f; git commit -m'upd'
scp -q -P 3000 $f rurban.xarch.at:film/
