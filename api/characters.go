package api

import (
	"fmt"
	"encoding/xml"
)

const CharacterURL = "https://api.eveonline.com/account/Characters.xml.aspx?keyID=%s&vCode=%s"

type Character struct {
	CharacterId string `xml:"characterID,attr"`
	Name string `xml:"name,attr"`
	CorporationName string `xml:"corporationName,attr"`
	CorporationId string `xml:"corporationID,attr"`
}

func CharacterParse(data []byte) []*Character {
	var eveapi struct {
		Characters []*Character `xml:"result>rowset>row"`
	}

	err := xml.Unmarshal(data, &eveapi)
	if err != nil {
		panic(err)
	}

	return eveapi.Characters
}

// GetCharacters retrieves character information for the key ID and API key provided.
func GetCharacters(keyId, keyCode string) []*Character {
	data := Call(fmt.Sprintf(CharacterURL, keyId, keyCode))
	return CharacterParse(data)
}
