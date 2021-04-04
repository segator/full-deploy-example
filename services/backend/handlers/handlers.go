package handlers

import (
	"github.com/gorilla/mux"
	"net/http"
	"sync/atomic"
	"time"
)

func Router() *mux.Router {
	isReady := &atomic.Value{}
	isReady.Store(false)
	go func() {
		time.Sleep(5 * time.Second)
		isReady.Store(true)
	}()
	r := mux.NewRouter()
	r.HandleFunc("/helloworld", helloFunction).Methods(http.MethodGet)
	http.Handle("/",r)
	r.HandleFunc("/healthz", healthz)
	r.HandleFunc("/readyz", readyz(isReady))
	return r
}