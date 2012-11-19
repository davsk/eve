package api

import (
	"fmt"
	"encoding/xml"
	"time"
)

const APIKeyInfoURL = "https://api.eveonline.com/account/APIKeyInfo.xml.aspx?keyID=%s&vCode=%s"

type APIKeyInfo struct {
	AccessMask int `xml:"accessMask,attr"`
	Type string `xml:"type,attr"`
	Expires time.Time `xml:"expires,attr"`
}

func APIKeyInfoParse(data []byte) *APIKeyInfo {
	var eveapi struct {
		APIKeyInfo *APIKeyInfo `xml:"result>key"`
	}

	err := xml.Unmarshal(data, &eveapi)
	if err != nil {
		panic(err)
	}

	return eveapi.APIKeyInfo
}

func GetAPIKeyInfo(keyId, keyCode string) *APIKeyInfo {
	data := Call(fmt.Sprintf(APIKeyInfoURL, keyId, keyCode))
	return APIKeyInfoParse(data)
}