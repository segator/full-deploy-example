package main

import (
	"backend/handlers"
	"context"
	fmt "fmt"
	log "github.com/sirupsen/logrus"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"syscall"
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
	log.Printf("Starting service on port %d",listenPort)
	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt, syscall.SIGTERM)

	server := &http.Server{
		Addr:    fmt.Sprintf(":%d",listenPort),
		Handler: handlers.Router(),
	}

	go func() {
		log.Fatal(server.ListenAndServe())
	}()
	log.Print("Service is ready to listen and serve.")
	<-interrupt
	log.Print("The service is shutting down...")
	server.Shutdown(context.Background())
}


