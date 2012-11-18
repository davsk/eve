package api

import (
	"fmt"
	"encoding/xml"
	"time"
)

const StatusURL = "https://api.eveonline.com/account/AccountStatus.xml.aspx?keyID=%s&vCode=%s"
const StatusMask = 33554432

type Status struct {
	PaidUntil time.Time `xml:"paidUntil"`
	CreateDate time.Time `xml:"createDate"`
	LogonCount int `xml:"logonCount"`
	LogonMinutes int `xml:"logonMinutes"`
}

func StatusParse(data []byte) *Status {
	var eveapi struct {
		Status *Status `xml:"result"`
	}

	err := xml.Unmarshal(data, &eveapi)
	if err != nil {
		panic(err)
	}

	return eveapi.Status
}

func GetStatus(keyId, keyCode string) *Status {
	data := Call(fmt.Sprintf(StatusURL, keyId, keyCode))
	return StatusParse(data)
}