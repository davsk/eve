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
)

func ImportEveCsv(fileNameIn string , fileNameOut string) (err error) {
	var (
		fileIn 	*os.file
		fileOut *os.file
		lineIn	[]byte
		lineOut []byte
		prefix 	bool
		valid 	bool
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
		// Read a line
		if lineIn, prefix, err = reader.ReadLine(); err != nil {
			break
		}

		// parse the line
		lineOut = lineIn

		// Write a line
		if valid {
			err := fileOut.WriteString(strings.TrimSpace(lineOut) + "\n")
		}
		else {
			err := fileOut.WriteString(strings.TrimSpace(lineOut) + " ")
		}
		if err != nil {
			return err
		}	
	}
}