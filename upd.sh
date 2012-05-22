#!/bin/sh
cmt=upd
[ -n $1 ] && cmt=$*
perl Cannes2012.txt |tee Cannes2012.sorted.html
f="Cannes2012.txt Cannes2012.sorted.html"
git commit -a -m"$cmt" && git push
scp -q -P 3000 $f rurban.xarch.at:film/
