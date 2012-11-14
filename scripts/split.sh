#! /usr/bin/env bash

# TODO old, update to work with latest scripts if needed
# if psql throws memory errors while trying to insert large amounts of data,
# this will split an sql file into smaller batches to run

echo "combining sql statements ..."

awk -v RS=';\n' -v ORS=";\n" 'gsub(/\n/, "") $0' < files/dump.sql > files/dump.sql.new

echo "splitting file ..."

cd tmp/
split -l 100000 dump.sql.new

ls x* | awk '{print "sed -i \"1s/^/BEGIN TRANSACTION;\\n/\" " $1}' | sh
ls x* | awk '{print "echo \"\\nEND TRANSACTION;\" >> " $1}' | sh

F=`ls x*`
len=`echo $F | wc -w`
i=0
for f in $F; do
	i=$[i+1]
	echo processing $i of $len
	psql -q eve -f $f
done

rm x*
