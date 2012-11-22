package analysis

import (
	"testing"
	"fmt"
)

func TestPrinting(t *testing.T) {
	var err error

	err = DailyBlueprintSelection()
	if err != nil {
		fmt.Println(err)
	}
}
