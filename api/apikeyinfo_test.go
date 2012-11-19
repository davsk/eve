package api

import (
	"fmt"
	"testing"
)

func TestAPIKeyInfoParse(t *testing.T) {

	data := []byte(`<?xml version='1.0' encoding='UTF-8'?>
	<eveapi version="2">
	<currentTime>2011-09-10 14:41:29</currentTime>
	<result>
	<key accessMask="59760264" type="Character" expires="2011-09-11 00:00:00">
	<rowset name="characters" key="characterID" columns="characterID,characterName,corporationID,corporationName">
	<row characterID="898901870" characterName="Desmont McCallock" corporationID="1000009" corporationName="Caldari Provisions" />
	</rowset>
	</key>
	</result>
	<cachedUntil>2011-09-10 14:46:29</cachedUntil>
	</eveapi>`)

	data = DateReplace(data)
	apiKeyInfo := APIKeyInfoParse(data)

	if apiKeyInfo == nil {
		t.Fatal("apiKeyInfo is nil!")
	}

	fmt.Println("AccessMask", apiKeyInfo.AccessMask)
	fmt.Println("Type", apiKeyInfo.Type)
	fmt.Println("Expires", apiKeyInfo.Expires)
}
