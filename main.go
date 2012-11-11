package main

import (
	"log"
	"net/http"
	"dasa.cc/dae"
	"dasa.cc/dae/user"
	"labix.org/v2/mgo/bson"
	"flag"
)

var adduser = flag.String("adduser", "", "add a new user with the given email")

func init() {
	dae.Cache = false
	dae.DBName = "eve"
	user.LoginSuccessURL = "/console/index"

	dae.RegisterFileServer("res/")
	user.RegisterHandlers()

	http.Handle("/console/profile", dae.NewHandler(dae.Auth, profile))
	http.Handle("/console/profile/update", dae.NewHandler(dae.Auth, profileUpdate))
	http.Handle("/console/profile/password", dae.NewHandler(dae.Auth, profilePassword))
}

func profile(w http.ResponseWriter, r *http.Request) *dae.Error {
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	u := user.Current(c, db)

	errs := []string{}
	msgs := []string{}

	for _, flash := range c.Session().Flashes() {
		f := flash.(string)
		if f[len(f)-1] == '!' {
			errs = append(errs, f)
		} else {
			msgs = append(msgs, f)
		}
	}
	c.Session().Save(r, w)

	dae.Render(w, r, bson.M{"User": u, "Errors": errs, "Messages": msgs})

	return nil
}

func profileUpdate(w http.ResponseWriter, r *http.Request) *dae.Error {
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	u := user.Current(c, db)

	// TODO truncate?
	u.Name = r.FormValue("name")

	if email := r.FormValue("email"); email != "" {
		u.Email = email
	}

	if err := db.C("users").UpdateId(u.Id, u); err != nil {
		return dae.NewError(err, 500, "Error updating user profile")
	}

	c.Session().AddFlash("Changes saved.")
	c.Session().Save(r, w)

	http.Redirect(w, r, "/console/profile", http.StatusFound)
	return nil
}

func profilePassword(w http.ResponseWriter, r *http.Request) *dae.Error {

	// redirect on return
	defer http.Redirect(w, r, "/console/profile", http.StatusFound)

	// setup env
	db := dae.NewDB()
	defer db.Close()

	c := dae.NewContext(r)
	defer c.Session().Save(r, w)

	u := user.Current(c, db)

	if !u.Validate(r.FormValue("oldpassword")) {
		c.Session().AddFlash("Old password incorrect!")
		return nil
	}

	newPass := r.FormValue("password")
	if newPass != r.FormValue("repeatpassword") {
		c.Session().AddFlash("New password doesn't match!")
		return nil
	}

	u.SetPassword(newPass)
	if err := db.C("users").UpdateId(u.Id, u); err != nil {
		return dae.NewError(err, 500, "Error updating user password!")
	}

	c.Session().AddFlash("Changes saved.")
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
