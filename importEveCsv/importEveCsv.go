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
	"bufio"
	"bytes"
	"fmt"
	"io"
	"log"
	"os"
	"unicode/utf8"
)

func ImportEveCsv(fileNameIn string, fileNameOut string) (err error) {
	const (
		iQuote = '"'
		iComma = ','
	)
	var (
		reader  *bufio.Reader
		fileIn  *os.File
		fileOut *os.File
		lineIn  []byte
		lineOut []byte
	)

	log.Println("Processing file " + fileNameIn)

	if fileIn, err = os.Open(fileNameIn); err != nil {
		return fmt.Errorf("Can't open fileNameIn: %s", err)
	}
	defer fileIn.Close()
	reader = bufio.NewReader(fileIn)

	if fileOut, err = os.Create(fileNameOut); err != nil {
		return fmt.Errorf("Can't create fileNameOut: %s", err)
	}
	defer fileOut.Close()

	// parse the line
	for {
		var (
			valid bool = false
			isOdd bool = false
			r1    rune = 0
			r2    rune = 0
			r3    rune = 0
		)

		// Read a line
		if lineIn, err = reader.ReadBytes('\n'); err != nil {
			if err == io.EOF {
				return nil
			}
			return fmt.Errorf("Error while calling ReadBytes: %s", err)
		}

		pos := 0
		length := len(lineIn)

		//log.Println(fmt.Sprintf("Handling new line of length %v", length))

		for pos < (length - 1) {

			//if pos > length {
			//	return fmt.Errorf("Somehow pos advanced past length! pos: %v, length: %v\n\nLine: %s", pos, length, lineIn)
			//}

			//log.Println(fmt.Sprintf("Handling position %v of %v", pos, length))

			//  Every valid quote is at beginning or ending of line 
			//  or next to comma that is next to a quote or null. 
			//  Invalid quotes can be changed to tick marks.
			var fixQuote bool = false
			p := lineIn[pos:]
			r, l := utf8.DecodeRune(p)
			pos += l

			if r == utf8.RuneError {
				return fmt.Errorf("Error decoding rune! %s", r)
			}

			r1 = r2
			r2 = r3
			r3 = r
			if r2 == iQuote {
				if r1 == 0 {
					isOdd = true
				} else if isOdd {
					if r3 == iComma {
						isOdd = false
					} else {
						fixQuote = true
					}
				} else if r1 == iComma {
					isOdd = true
				} else {
					fixQuote = true
				}
			}
			if r2 != 0 {
				if fixQuote {
					_, err = fileOut.WriteString("'")
				} else {
					_, err = fileOut.WriteString(string(r2))
				}
			}
		}

		//  Every valid line ends with ,null\n or \"\n 
		valid = bytes.HasSuffix(lineOut, []byte(",null")) || bytes.HasSuffix(lineOut, []byte("\""))

		//  I need to print lines with valid endings with /n 
		//  and the invalid endings are printed with a space at the end.
		// Write a line
		if valid {
			_, err = fileOut.WriteString(string(r3) + "\n")
		} else {
			_, err = fileOut.WriteString(string(r3) + " ")
		}
		if err != nil {
			return err
		}
	}

	return err
}
