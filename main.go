package main

import (
	"dasa.cc/dae"
	"dasa.cc/dae/datastore"
	"dasa.cc/dae/handler"
	"dasa.cc/dae/render"
	"dasa.cc/dae/user"
	"flag"
	"log"
	"net/http"
)

var adduser = flag.String("adduser", "", "add a new user with the given email")

func main() {
	flag.Parse()

	if *adduser != "" {
		u := user.New()
		u.Email = *adduser
		u.SetPassword("qwerty42")
		db := datastore.New()
		defer db.Close()
		if err := db.C("users").Insert(u); err != nil {
			log.Fatal(err)
		}
		log.Print("user added, password is `qwerty42`.")
	} else {
		log.Fatal(http.ListenAndServe("localhost:8085", nil))
	}
}

func init() {
	render.Cache = false
	handler.Debug = false

	datastore.DBHost = "localhost"
	datastore.DBName = "eve"

	user.LoginSuccessURL = "/console/"

	dae.RegisterFileServer("res/")
	user.RegisterHandlers()
}
