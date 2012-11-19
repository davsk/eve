package main

import (
	"dasa.cc/dae/context"
	"dasa.cc/dae/datastore"
	"dasa.cc/dae/handler"
	"dasa.cc/dae/render"
	"dasa.cc/dae/user"
	"dasa.cc/eve/api"
	"labix.org/v2/mgo/bson"
	"net/http"
)

type UserData struct {
	APIKeys     []*api.APIKey
	ActiveKeyId string
}

func eveapi(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	var data UserData
	u.Data(&data)

	render.Auto(w, r, bson.M{"User": u, "Data": data})

	return nil
}

func eveapiCharacters(w http.ResponseWriter, r *http.Request) *handler.Error {
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

func eveapiStatus(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	var data UserData
	u.Data(&data)

	var status *api.Status

	if len(data.APIKeys) != 0 {
		apikey := data.APIKeys[0]

		for _, key := range data.APIKeys {
			if key.Id == data.ActiveKeyId {
				apikey = key
				break
			}
		}

		status = api.GetStatus(apikey.Id, apikey.Code)
	}

	render.Auto(w, r, bson.M{"User": u, "Data": data, "Status": status})

	return nil
}

func eveapiSetActive(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	var data UserData
	u.Data(&data)

	id := r.FormValue("id")
	data.ActiveKeyId = id

	u.SetData(data)

	if err := db.C("users").UpdateId(u.Id, u); err != nil {
		return handler.NewError(err, 500, "Error updating active api key.")
	}

	return nil
}

func init() {
	http.Handle("/eveapi/", handler.New(handler.Auth, eveapi))
	http.Handle("/eveapi/characters", handler.New(handler.Auth, eveapiCharacters))
	http.Handle("/eveapi/status", handler.New(handler.Auth, eveapiStatus))
	http.Handle("/eveapi/setactive", handler.New(handler.Auth, eveapiSetActive))
}
