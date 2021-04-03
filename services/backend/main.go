package main

import (
	"backend/handlers"
	"fmt"
	log "github.com/sirupsen/logrus"
	"net/http"
	"os"
	"strconv"
)
const (
 helloListenPortEnvVarName="HELLO_LISTEN_PORT"
 helloListenDefaultPort=int64(8000)
)
var(
	listenPort=helloListenDefaultPort
)
func main() {
	envHelloListenPort :=os.Getenv(helloListenPortEnvVarName)
	if envHelloListenPort !="" {
		var err error
		listenPort,err=strconv.ParseInt(envHelloListenPort,10,16)
		if err!=nil{
			log.Fatal(err)
		}
	}
	log.Printf("Starting server on port %d",listenPort)
	router := handlers.Router()
	http.ListenAndServe(fmt.Sprintf(":%d",listenPort), router)
}


