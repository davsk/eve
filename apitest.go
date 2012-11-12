package main

import (
	"dasa.cc/dae"
	"dasa.cc/dae/user"
	"net/http"
	"labix.org/v2/mgo/bson"
	"dasa.cc/eve/api"
)

func init() {
	http.Handle("/apitest/index", dae.Handler(dae.Auth).Add(apitest))
	http.Handle("/apitest/characters", dae.Handler(dae.Auth).Add(apitestCharacters))
	http.Handle("/apitest/status", dae.Handler(dae.Auth).Add(apitestStatus))
}

func apitest(w http.ResponseWriter, r *http.Request) *dae.Error {
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	u := user.Current(c, db)

	dae.Render(w, r, bson.M{"User": u})

	return nil
}

func apitestCharacters(w http.ResponseWriter, r *http.Request) *dae.Error {
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	u := user.Current(c, db)

	apikey := u.Data["apikeys"].([]interface{})[0].(bson.M)
	chars := api.GetCharacters(apikey["id"].(string), apikey["code"].(string))

	dae.Render(w, r, bson.M{"User": u, "Characters": chars})

	return nil
}

func apitestStatus(w http.ResponseWriter, r *http.Request) *dae.Error {
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	u := user.Current(c, db)

	dae.Render(w, r, bson.M{"User": u})

	return nil
}

