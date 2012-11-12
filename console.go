package main

import (
	"dasa.cc/dae/handler"
	"dasa.cc/dae/datastore"
	"dasa.cc/dae/context"
	"dasa.cc/dae/user"
	"dasa.cc/dae/render"
	"labix.org/v2/mgo/bson"
	"net/http"
)

func console(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	render.Auto(w, r, bson.M{"User": u})
	return nil
}

func init() {
	http.Handle("/console/index", handler.New(handler.Auth, console))
}
