/* importEveCsv.go

by David Skinner
for DASA
on Nov 29, 2012

Every valid quote is at beginning or ending of line or next to comma that is next to a quote. Invalid quotes can be changed to tick marks.

Every valid line ends with ,null\n or \"\n 

I need to print lines with valid endings with /n and the invalid endings are printed with a space at the end.
*/

package importEveCsv

import (
	"os"
	"fmt"
	"strings"
	"unicode/utf8"
)

func ImportEveCsv(fileNameIn string , fileNameOut string) (err error) {
	const (
		iQuote, lQuote 	= utf8.DecodeRune("\"")
		iComma, lComma 	= utf8.DecodeRune(",")
		iL, lL 			= utf8.DecodeRune(",")
		iN, lN 			= utf8.DecodeRune(",")
	)
	var (
		fileIn 	*os.file
		fileOut *os.file
		lineIn	[]byte
		lineOut []byte
		prefix 	bool
	)

	if fileIn, err = os.Open(fileNameIn); err != nil {
		return err
	}	
	defer fileIn.Close()

	if fileOut, err = os.Create(fileNameOut); err != nil {
		return err
	}
	defer fileOut.Close()

	for {
		var (
			valid bool = false
			idOdd bool = false
			r1 int = 0
			r2 int = 0
			r3 int = 0
		)

		// Read a line
		if lineIn, prefix, err = reader.ReadLine(); err != nil {
			break
		}

		pos := 0
		length := utf8.RuneCount(lineIn)
		
		for pos != length {
			var fixQuote bool = false
			p := lineIn[pos:]
			r, l := utf8.DecodeRune(p)
			if r != utf8.RuneError {
				r1 = r2
				r2 = r3
				r3 = r
				if (r2 == iQuote) {
					if (r1 == 0) {
						isOdd = true
					} else if (isOdd) {
						if (r3 == iComma) {
							isOdd = false
						} else {
							fixQuote = true
						}
					} else if (r1 == iComma) {
						isOdd = true
					} else {
						fixQuote = true
					}
				}
				if (r2 != 0) {
					if (fixQuote) {
						err := fileOut.WriteString("'")
					} else {
						err := fileOut.WriteString(string(r2))		
					}
				} 
			}
			
			pos += l

			// parse the line
			//  Every valid quote is at beginning or ending of line 
			//  or next to comma that is next to a quote or null. 
			//  Invalid quotes can be changed to tick marks.
		}
			
		//  Every valid line ends with ,null\n or \"\n 
		valid = strings.HasSuffix(lineOut,",null") || strings.HasSuffix(lineOut,"\"")

		//  I need to print lines with valid endings with /n 
		//  and the invalid endings are printed with a space at the end.
		// Write a line
		if valid {
			err := fileOut.WriteString(string(r3) + "\n")
		}
		else {
			err := fileOut.WriteString(string(r3)) + " ")
		}
		if err != nil {
			return err
		}	
	}
}