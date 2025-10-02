package main

import (
	"log"
	"net/http"
	"os"

	"github.com/dghwood/resonate/api"
	cacheService "github.com/dghwood/resonate/services/cachestore"
	datastoreService "github.com/dghwood/resonate/services/datastore"
	fetchService "github.com/dghwood/resonate/services/fetch"
	searchService "github.com/dghwood/resonate/services/search"

	"github.com/dghwood/resonate/api/auth"
	"github.com/dghwood/resonate/api/feed"
	"github.com/dghwood/resonate/api/follows"
	"github.com/dghwood/resonate/api/listens"
	"github.com/dghwood/resonate/api/podcast"
	"github.com/dghwood/resonate/api/search"
	"github.com/dghwood/resonate/api/subscribe"
	"github.com/dghwood/resonate/api/users"
)

func main() {
	log.Println("Starting server...")
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}

	datastore := datastoreService.NewMemoryDatastore()
	// searchApi := searchService.NewMockSearch()

	cachestore := cacheService.NewMemoryCachestore()
	fetch := fetchService.NewCached(cachestore)
	searchApi := searchService.NewTaddySearch(fetch)

	// Login API endpoints
	api.Attach(&auth.Login{
		Datastore: datastore}, "/api/login")
	api.Attach(&auth.Refresh{
		Datastore: datastore}, "/api/login/refresh")
	api.Attach(&auth.Request{
		Datastore: datastore}, "/api/login/request")

	// Podcast
	api.Attach(&podcast.Get{
		FetchClient: fetch,
		Datastore:   datastore}, "/api/podcast/get")
	api.Attach(&podcast.List{
		Datastore:   datastore,
		FetchClient: fetch}, "/api/podcast/list")

	// Subscriptions
	api.Attach(&subscribe.List{
		Datastore: datastore}, "/api/subscribe/list")
	api.Attach(&subscribe.Add{
		Datastore: datastore}, "/api/subscribe/add")
	api.Attach(&subscribe.Remove{
		Datastore: datastore}, "/api/subscribe/remove")

	// Follows
	api.Attach(&follows.List{
		Datastore: datastore}, "/api/follow/list")
	api.Attach(&follows.Add{
		Datastore: datastore}, "/api/follow/add")
	api.Attach(&follows.Remove{
		Datastore: datastore}, "/api/follow/remove")

	// Listens
	api.Attach(&listens.List{
		Datastore: datastore}, "/api/listens/list")
	api.Attach(&listens.Add{
		Datastore: datastore}, "/api/listens/add")
	api.Attach(&listens.Remove{
		Datastore: datastore}, "/api/listens/remove")

	// Users
	api.Attach(&users.List{
		Datastore: datastore}, "/api/users/list")
	api.Attach(&users.Edit{
		Datastore: datastore}, "/api/users/edit")
	api.Attach(&users.Get{
		Datastore: datastore}, "/api/users/get")

	// Feed
	api.Attach(&feed.Get{
		Datastore: datastore}, "/api/feed/get")

	// Search
	api.Attach(&search.Query{
		SearchApi: searchApi,
		Datastore: datastore}, "/api/search/query")
	api.Attach(&search.Top{
		SearchApi: searchApi,
		Datastore: datastore}, "/api/search/top")

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
