package main

import (
	"log"
	"net/http"
	"os"

	"github.com/dghwood/resonate/api"
	"github.com/dghwood/resonate/services/datastore"

	"github.com/dghwood/resonate/api/auth"
	"github.com/dghwood/resonate/api/subscribe"
)

func main() {
	log.Println("Starting server...")
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}

	ds := datastore.NewMemoryDatastore()

	// Login API endpoints
	api.Attach(auth.Login{}, "/api/login")
	api.Attach(auth.Refresh{}, "/api/login/refresh")
	api.Attach(auth.Request{}, "/api/login/request")

	// Subscriptions
	api.Attach(&subscribe.List{Datastore: ds}, "/api/subscribe/list")

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
