package api

import (
	"testing"
	"fmt"
)

func TestCharactersParse(t *testing.T) {

	defer func() {
		if r := recover(); r != nil {
			t.Fatal(r)
		}
	}()

	data := []byte(`<?xml version='1.0' encoding='UTF-8'?>
	<eveapi version="2">
	<currentTime>2012-11-12 03:15:28</currentTime>
	<result>
	<rowset name="characters" key="characterID" columns="name,characterID,corporationName,corporationID">
	<row name="Character Name" characterID="01234567" corporationName="Corp Name" corporationID="0123456789" />
	</rowset>
	</result>
	<cachedUntil>2012-11-12 04:12:28</cachedUntil>
	</eveapi>`)

	chars := CharacterParse(data)

	for _, char := range chars {
		fmt.Println(*char)
	}
}
