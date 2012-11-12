package main

import (
	"dasa.cc/dae/handler"
	"net/http"
)

func index(w http.ResponseWriter, r *http.Request) *handler.Error {
	http.Redirect(w, r, "/login", http.StatusFound)
	return nil
}

func init() {
	http.Handle("/", handler.New(index))
}
