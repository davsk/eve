package main

import (
	"dasa.cc/dae"
	"dasa.cc/dae/user"
	"flag"
	"log"
	"net/http"
)

var adduser = flag.String("adduser", "", "add a new user with the given email")

func init() {
	dae.Cache = false
	dae.DBName = "eve"
	user.LoginSuccessURL = "/console/index"

	dae.RegisterFileServer("res/")
	user.RegisterHandlers()

	http.Handle("/", dae.NewHandler(index))
}

func index(w http.ResponseWriter, r *http.Request) *dae.Error {
	http.Redirect(w, r, "/login", http.StatusFound)
	return nil
}

func main() {
	flag.Parse()

	if *adduser != "" {
		u := user.New()
		u.Email = *adduser
		u.SetPassword("qwerty42")
		db := dae.NewDB()
		defer db.Close()
		if err := db.C("users").Insert(u); err != nil {
			log.Fatal(err)
		}
		log.Print("user added, password is `qwerty42`.")
	} else {
		log.Fatal(http.ListenAndServe("localhost:8085", nil))
	}
}
