package main

import (
	"testing"
	"fmt"
)

func TestTableNames(t *testing.T) {

	tableNames := GetTableNames()
	for _, name := range tableNames {
		columns := GetColumnNames(name)
		fmt.Println(name)
		for _, n := range columns {
			fmt.Println("-> ", n)
		}
	}
}