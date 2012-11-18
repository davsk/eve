package api

import (
	"fmt"
	"testing"
)

func TestStatusParse(t *testing.T) {

	defer func() {
		if r := recover(); r != nil {
			t.Fatal(r)
		}
	}()

	data := []byte(`<?xml version='1.0' encoding='UTF-8'?>
	<eveapi version="2">
  <currentTime>2010-10-05 20:28:55</currentTime>
  <result>
  <paidUntil>2011-01-01 00:00:00</paidUntil>
  <createDate>2004-01-01 00:00:00</createDate>
  <logonCount>9999</logonCount>
  <logonMinutes>9999</logonMinutes>
  </result>
  <cachedUntil>2010-10-05 20:33:55</cachedUntil>
	</eveapi>`)

	data = DateReplace(data)
	status := StatusParse(data)

	fmt.Println("CreateDate", status.CreateDate)
	fmt.Println("PaidUntil", status.PaidUntil)
	fmt.Println("LogonCount", status.LogonCount)
	fmt.Println("LoginMinutes", status.LogonMinutes)
}