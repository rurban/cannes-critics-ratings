#!/bin/sh
perl Cannes2012.txt |tee Cannes2012.sorted.html
scp -q -P 3000 Cannes2012.txt Cannes2012.sorted.html rurban.xarch.at:film/
