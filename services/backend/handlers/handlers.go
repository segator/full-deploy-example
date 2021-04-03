package handlers

import (
	"github.com/gorilla/mux"
	"net/http"
)

func Router() *mux.Router {
	r := mux.NewRouter()
	r.HandleFunc("/helloworld", helloFunction).Methods(http.MethodGet)
	http.Handle("/",r)
	return r
}