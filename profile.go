package main

import (
	"net/http"
	"dasa.cc/dae"
	"dasa.cc/dae/user"
	"labix.org/v2/mgo/bson"
)

func init() {
	http.Handle("/console/profile", dae.NewHandler(dae.Auth, profile))
	http.Handle("/console/profile/update", dae.NewHandler(dae.Auth, profileUpdate))
	http.Handle("/console/profile/password", dae.NewHandler(dae.Auth, profilePassword))
	http.Handle("/console/profile/apikeys", dae.Handler(dae.Auth).Add(apikeys))
}

type UserData struct {
	ApiKeys []*APIKey
}

type APIKey struct {
	Name string
	Id string
	Code string
}

func apikeys(w http.ResponseWriter, r *http.Request) *dae.Error {
	if err := r.ParseForm(); err != nil {
		return dae.NewError(err, 500, "Error parsing form data")
	}

	c := dae.NewContext(r)

	db := dae.NewDB()
	defer db.Close()

	u := user.Current(c, db)

	var apiKeys []*APIKey

	names := r.Form["keyname"]
	ids := r.Form["keyid"]
	codes := r.Form["keycode"]

	for i := 0; i < len(names); i++ {
		apiKeys = append(apiKeys, &APIKey{names[i], ids[i], codes[i]})
	}

	u.Data["apikeys"] = apiKeys

	if err := db.C("users").UpdateId(u.Id, u); err != nil {
		return dae.NewError(err, 500, "Error saving api keys")
	}

	c.Session().AddFlash("Changes saved.")
	c.Session().Save(r, w)

	http.Redirect(w, r, "/console/profile", http.StatusFound)

	return nil
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


