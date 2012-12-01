#! /usr/bin/gawk -f

function handlebuf() {
	# see if we have accumulated a buffer
	if (buf) {
		# check if buffer is not properly terminated
		if (!match(buf, /"$/)) {
			# fix it
			buf = buf "\""
		}
		print buf "\n\n"
		buf = ""
	}
}

{
	# dos2unix
	sub("\r$", "")
}

# print records ending with double-quote but not comma + double-quote
/"$/ && !/,"$/ {
	if (!buf) {
		# print $0
		next
	}
}

# new records start with `"[num]","` where [num] is up to three digits long.
# this signals to print an accumulated buffer.
/^"[0-9].?.?","/ {
	handlebuf()
}

{
	buf = buf " " $0
}

END {
	handlebuf()
}
