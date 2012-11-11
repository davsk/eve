package main

import (
	"net/http"
	"dasa.cc/dae"
	"dasa.cc/dae/user"
	"labix.org/v2/mgo/bson"
)

func init() {
	http.Handle("/console/index", dae.Handler(dae.Auth).Add(index))
}

func index(w http.ResponseWriter, r *http.Request) *dae.Error {
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	u := user.Current(c, db)


	dae.Render(w, r, bson.M{"User": u})
	return nil
}
