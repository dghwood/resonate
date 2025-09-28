package main

import (
	"log"
	"net/http"
	"os"

	"github.com/dghwood/resonate/api"
	"github.com/dghwood/resonate/services/datastore"

	"github.com/dghwood/resonate/api/auth"
	"github.com/dghwood/resonate/api/follows"
	"github.com/dghwood/resonate/api/listens"
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
	api.Attach(&subscribe.Add{Datastore: ds}, "/api/subscribe/add")
	api.Attach(&subscribe.Remove{Datastore: ds}, "/api/subscribe/remove")

	// Subscriptions
	api.Attach(&follows.List{Datastore: ds}, "/api/follow/list")
	api.Attach(&follows.Add{Datastore: ds}, "/api/follow/add")
	api.Attach(&follows.Remove{Datastore: ds}, "/api/follow/remove")

	// Listens
	api.Attach(&listens.List{Datastore: ds}, "/api/listens/list")
	api.Attach(&listens.Add{Datastore: ds}, "/api/listens/add")
	api.Attach(&listens.Remove{Datastore: ds}, "/api/listens/remove")

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
