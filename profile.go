package main

import (
	"net/http"
	"dasa.cc/dae/handler"
	"dasa.cc/dae/datastore"
	"dasa.cc/dae/context"
	"dasa.cc/dae/user"
	"dasa.cc/dae/render"
	"labix.org/v2/mgo/bson"
)

func apikeys(w http.ResponseWriter, r *http.Request) *handler.Error {
	if err := r.ParseForm(); err != nil {
		return handler.NewError(err, 500, "Error parsing form data")
	}

	c := context.New(r)

	db := datastore.New()
	defer db.Close()

	u := user.Current(c, db)

	var apiKeys []*APIKey

	names := r.Form["keyname"]
	ids := r.Form["keyid"]
	codes := r.Form["keycode"]

	for i := 0; i < len(names); i++ {
		apiKeys = append(apiKeys, &APIKey{names[i], ids[i], codes[i]})
	}

	var data UserData
	u.Data(&data)

	data.APIKeys = apiKeys
	if err := u.SetData(&data); err != nil {
		return handler.NewError(err, 500, "Error setting user data")
	}

	if err := db.C("users").UpdateId(u.Id, u); err != nil {
		return handler.NewError(err, 500, "Error saving api keys")
	}

	c.Session().AddFlash("Changes saved.")
	c.Session().Save(r, w)

	http.Redirect(w, r, "/console/profile", http.StatusFound)

	return nil
}

func profile(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
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

	var data UserData
	u.Data(&data)

	render.Auto(w, r, bson.M{"User": u, "Data": data, "Errors": errs, "Messages": msgs})

	return nil
}

func profileUpdate(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	// TODO truncate?
	u.Name = r.FormValue("name")

	if email := r.FormValue("email"); email != "" {
		u.Email = email
	}

	if err := db.C("users").UpdateId(u.Id, u); err != nil {
		return handler.NewError(err, 500, "Error updating user profile")
	}

	c.Session().AddFlash("Changes saved.")
	c.Session().Save(r, w)

	http.Redirect(w, r, "/console/profile", http.StatusFound)
	return nil
}

func profilePassword(w http.ResponseWriter, r *http.Request) *handler.Error {

	// redirect on return
	defer http.Redirect(w, r, "/console/profile", http.StatusFound)

	// setup env
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
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
		return handler.NewError(err, 500, "Error updating user password!")
	}

	c.Session().AddFlash("Changes saved.")
	return nil
}

func init() {
	http.Handle("/console/profile", handler.New(handler.Auth, profile))
	http.Handle("/console/profile/update", handler.New(handler.Auth, profileUpdate))
	http.Handle("/console/profile/password", handler.New(handler.Auth, profilePassword))
	http.Handle("/console/profile/apikeys", handler.Handler(handler.Auth).Add(apikeys))
}
