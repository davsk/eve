package analysis

import (
	"testing"
)

func TestPrinting(t *testing.T) {
	var err error

	err = DailyBlueprintSelection()
	if err != nil {
		t.Fatal(err)
	}
}
