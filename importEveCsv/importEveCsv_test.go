/* importEveCsv_test.go

by David Skinner
for DASA
on Nov 29, 2012

Every valid quote is at beginning or ending of line or next to comma that is next to a quote. Invalid quotes can be changed to tick marks.

Every valid line ends with ,null\n or \"\n 

I need to print lines with valid endings with /n and the invalid endings are printed with a space at the end.
*/

package importEveCsv

import (
	"testing"
)

func TestImportEveCsv(t *testing.T) {
	var err error

	err = ImportEveCsv("../sql/tmp/invItems.csv", "../sql/tmp/invItems.tmp")
	if err != nil {
		t.Fatal(err)
	}

	err = ImportEveCsv("../sql/tmp/trnTranslations.csv", "../sql/tmp/trnTranslations.tmp")
	if err != nil {
		t.Fatal(err)
	}
}
