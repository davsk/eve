#! /usr/bin/env bash

# psql throws memory errors while trying to insert large amounts of data
# with low system memory. This will split an sql file into smaller batches to
# run

echo "stripping transaction ..."
sed -i -e '$d' -e '1d' $1

echo "combining sql statements ..."
awk -v RS=';\n' -v ORS=";\n" 'gsub(/\n/, "") $0' $1 > $1.new
mv $1.new $1

echo "splitting file ..."
cd tmp/
split -l 50 `basename $1`

rm `basename $1`

ls x* | awk '{print "sed -i \"1s/^/begin transaction;\\n/\" " $1}' | sh
ls x* | awk '{print "echo \"\\nend transaction;\" >> " $1}' | sh

F=`ls x*`
len=`echo $F | wc -w`
i=0
for f in $F; do
	i=$[i+1]
	echo processing $i of $len
	psql eve -f $f
done

rm x*
