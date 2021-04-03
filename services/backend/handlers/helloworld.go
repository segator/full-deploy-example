package handlers

import (
	"encoding/json"
	"net/http"
)

type Response struct{
	Hello string `json:"hello"`
}


func helloFunction(w http.ResponseWriter, req *http.Request) {
	response := Response{Hello:"world"}

	js, err := json.Marshal(response)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(js)
}
