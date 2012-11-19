package api

import (
	"io/ioutil"
	"net/http"
	"regexp"
	"time"
)

const (
	eveDateFormat = "2006-01-02 15:04:05"
	eveDateMatch  = "[0-9]...-[0-9].-[0-9]. [0-9].:[0-9].:[0-9]."
)

var dateMatcher *regexp.Regexp

type APIKey struct {
	Name  string
	Id    string
	Code  string
	Info  *APIKeyInfo
}

// DateReplace matches dates in the given src and formats them in a manner that will
// be recognized by xml.Unmarshal
// 
// This works around an issue with Go 1.0.x and the removed xml.Unmarshal
// interface since they couldn't commit to what was their for backwards compat
// promised with Go1. Might get fixed in Go 1.1
func DateReplace(src []byte) []byte {
	return dateMatcher.ReplaceAllFunc(src, func(date []byte) []byte {
		t, err := time.Parse(eveDateFormat, string(date))
		if err != nil {
			panic(err)
		}
		return []byte(t.Format(time.RFC3339))
	})
}

func Call(url string) []byte {
	resp, err := http.Get(url)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}

	if resp.StatusCode != http.StatusOK {
		panic(string(body))
	}
	
	return DateReplace(body)
}

func init() {
	r, err := regexp.Compile(eveDateMatch)
	if err != nil {
		panic(err)
	}
	dateMatcher = r
}
