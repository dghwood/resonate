package main

import (
	"net/http"
	"os"

	"github.com/dghwood/resonate/api"
	cacheService "github.com/dghwood/resonate/services/cachestore"
	datastoreService "github.com/dghwood/resonate/services/datastore"
	fetchService "github.com/dghwood/resonate/services/fetch"
	imagestoreService "github.com/dghwood/resonate/services/imagestore"
	searchService "github.com/dghwood/resonate/services/search"

	"github.com/dghwood/resonate/api/auth"
	"github.com/dghwood/resonate/api/feed"
	"github.com/dghwood/resonate/api/follows"
	"github.com/dghwood/resonate/api/listens"
	"github.com/dghwood/resonate/api/podcast"
	"github.com/dghwood/resonate/api/search"
	"github.com/dghwood/resonate/api/subscribe"
	"github.com/dghwood/resonate/api/upload"
	"github.com/dghwood/resonate/api/users"
	"github.com/dghwood/resonate/log"
)

func main() {
	log.Info("Starting server...")
	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}

	env_variables := []string{
		"USER_ID_SALT",
		"TADDY_USER_ID",
		"TADDY_API_KEY",
		"GOOGLE_APPLICATION_CREDENTIALS",
	}

	for _, env_var := range env_variables {
		_, ok := os.LookupEnv(env_var)
		if !ok {
			log.Errorf("Environment variable %s not set", env_var)
			return
		}
	}

	datastore := datastoreService.NewMemoryDatastore()
	// searchApi := searchService.NewMockSearch()

	cachestore := cacheService.NewMemoryCachestore()
	imagestore := imagestoreService.NewMemoryImageStore()
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

	// Upload
	api.Attach(&upload.Image{
		Datastore: imagestore}, "/api/upload/image")

	// Matches all paths /images/users/.*
	http.HandleFunc("/images/users/", func(w http.ResponseWriter, r *http.Request) {
		// CORs headers
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		if r.Method == "OPTIONS" {
			return
		}
		log.Info(r.URL.Path)
		resourceId := r.URL.Path[len("/images/users/"):]
		if len(resourceId) == 0 {
			http.Error(w, "Invalid resourceId", http.StatusBadRequest)
			return
		}
		log.Infof("getting resourceId: %s", resourceId)
		image, err := imagestore.Get(resourceId, 0)
		if err != nil {
			log.Error(err)
			http.Error(w, "Image not found", http.StatusNotFound)
			return
		}
		// w.Header().Set("Content-Type", "image/png")
		w.Write(image)
	})

	log.Error(http.ListenAndServe(":"+port, nil))
}
