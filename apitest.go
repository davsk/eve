package main

import (
	"dasa.cc/dae/handler"
	"dasa.cc/dae/context"
	"dasa.cc/dae/datastore"
	"dasa.cc/dae/user"
	"dasa.cc/dae/render"
	"net/http"
	"labix.org/v2/mgo/bson"
	"dasa.cc/eve/api"
)

type APIKey struct {
	Name string
	Id string
	Code string
}

type UserData struct {
	APIKeys []*APIKey
}

func apitest(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	var data UserData
	u.Data(&data)

	render.Auto(w, r, bson.M{"User": u, "Data": data})

	return nil
}

func apitestCharacters(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	var data UserData
	u.Data(&data)

	var chars []*api.Character

	if len(data.APIKeys) != 0 {
		apikey := data.APIKeys[0]
		chars = api.GetCharacters(apikey.Id, apikey.Code)
	}

	render.Auto(w, r, bson.M{"User": u, "Data": data, "Characters": chars})

	return nil
}

func apitestStatus(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	var data UserData
	u.Data(&data)

	render.Auto(w, r, bson.M{"User": u, "Data": data})

	return nil
}

func init() {
	http.Handle("/apitest/index", handler.New(handler.Auth, apitest))
	http.Handle("/apitest/characters", handler.New(handler.Auth, apitestCharacters))
	http.Handle("/apitest/status", handler.New(handler.Auth, apitestStatus))
}
