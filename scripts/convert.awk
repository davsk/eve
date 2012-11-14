#! /usr/bin/gawk -f

BEGIN {
	IGNORECASE = 1 # gawkism
	print "begin transaction;"
}

{
	gsub("\r$", "") # dos2unix
}

# skip comments
/^#/ || /^--/ || /^(un)?lock/ || /^$/ || /^[ \t]*$/ || /\/\*.*\*\// || /^([\( ])?partition/ { next }

{
	gsub(/`/, "") # remove backticks around system identifiers
	gsub(/'0000-00-00 00:00:00'/, "'-infinity'::timestamp") # cast zero'd timestamp value on table defs, inserts, etc
}

/^drop / {
	print
	next
}

/^create / {
	if (match($0, /table .*\(/)) {
		tableName = substr($0, RSTART+6, RLENGTH-8)
	}
	print
	next
}

/^,/ {
	sub(/^,/, " ")
}

/,$/ {
	sub(/,$/, "")
}

#
/^insert/ {
	gsub( /\\\047/, "\047\047" ) gsub(/\\n/, "\n")
	gsub(/\\r/, "\r")
	gsub(/\\"/, "\"")
	gsub(/\\\\/, "\\")
	gsub(/\\\032/, "\032")
	print
	next
}

/^\)/ {
	if (prev) print prev
	prev = ""
	print ");"
	next
}

# store indexes for creation later
/^[ \t]*key/ {
	if (match($0, /^[ \t]*key .*\(/)) indexName = substr($0, RSTART+6, RLENGTH-7)
	if (match($0, /\(.*\)/)) indexKey = substr($0, RSTART+1, RLENGTH-2)
	key[tableName] = key[tableName] "create index " tableName "_" indexName " on " tableName " (" indexKey ");\n"
	next
}

# field defs
/^[ \t]*/ {

	#sub(/,[ \t]*(.*)[ \t]/, "\1") # quote field names for safety

	if (!/^[ \t]*primary key/) {
		sub($1, "\""$1"\"") # quote field name for safety
	}
	sub(/comment.*/, "") # strip comments
	sub(/[ \t]*$/, "") # remove trailing whitespace

	#
	sub(/tinyint(\([0-9]*\))?/, "smallint")
	sub(/smallint(\([0-9]*\))?/, "smallint")
	sub(/mediumint(\([0-9]*\))?/, "int")
	sub(/bigint(\([0-9]*\))?/, "bigint")
	sub(/int(\([0-9]*\))?/, "int")

	sub(/smallint[ \t]*unsigned/, "int")
	sub(/mediumint[ \t]*unsigned/, "int")
	sub(/int[ \t]*unsigned/, "bigint")
	sub(/bigint[ \t]*unsigned/, "numeric(20)")

	sub(/float( unsigned)?/, "real")
	sub(/double/, "double precision")

	sub(/bigint[ \t]*auto_increment/, "serial")

	sub(/tinytext/, "text")
	sub(/mediumtext/, "text")
	sub(/longtext/, "text")
	
	sub(/datetime/, "timestamp")
	sub(/now\(\)/, "current_timestamp")
	if (/ timestamp .* default/) {
		sub(/default 0/, "default '-infinity'::timestamp")
	}

	if (prev) print prev ","
	prev = $0
}

END {
	for (table in key) printf key[table]
	print "end transaction;"
}
