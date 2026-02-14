package main

import (
	"net/http"
	"os"

	"github.com/dghwood/resonate/api"
	"github.com/dghwood/resonate/flags"
	cacheService "github.com/dghwood/resonate/services/cachestore/cloudstorage"
	datastoreService "github.com/dghwood/resonate/services/datastore/firestore"
	fetchService "github.com/dghwood/resonate/services/fetch"
	imagestoreService "github.com/dghwood/resonate/services/imagestore/cloudstorage"
	searchService "github.com/dghwood/resonate/services/search"
	"github.com/dghwood/resonate/services/secrets"
	"github.com/dghwood/resonate/services/sms"

	smsMemoryVerificationService "github.com/dghwood/resonate/services/sms/memory"
	smsTwilioVerificationService "github.com/dghwood/resonate/services/sms/twilio"

	"github.com/dghwood/resonate/api/auth"
	"github.com/dghwood/resonate/api/feed"
	"github.com/dghwood/resonate/api/find"
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
	flags.Parse()
	// Loads the Env Variables from the Secrets Manager
	err := secrets.AccessSecrets(flags.FLAGS.CloudSecretsKey)
	if err != nil {
		log.Error(err)
		return
	}

	env_variables := []string{
		"USER_ID_SALT",
		"TADDY_USER_ID",
		"TADDY_API_KEY",
	}

	for _, env_var := range env_variables {
		_, ok := os.LookupEnv(env_var)
		if !ok {
			log.Errorf("Environment variable %s not set", env_var)
			return
		}
	}

	var projectID = flags.FLAGS.CloudProjectId
	var databaseId = flags.FLAGS.CloudDatabaseId

	cachestore := cacheService.NewStorageCachestore(flags.FLAGS.CloudStorageBucketCache)
	fetch := fetchService.NewCached(cachestore)
	imagestore := imagestoreService.NewStorageCachestore(flags.FLAGS.CloudStorageBucketImages)
	datastore := datastoreService.NewFirestoreDatastore(projectID, databaseId)
	searchApi := searchService.NewTaddySearch(fetch)
	// SMS
	var smsVerification sms.Verification
	if flags.FLAGS.EnableSms {
		smsVerification = smsTwilioVerificationService.NewTwilioVerification()
	} else {
		smsVerification = smsMemoryVerificationService.NewMemoryVerification()
	}

	// Login API endpoints
	api.Attach(&auth.Login{
		SmsVerification: smsVerification,
		Datastore:       datastore}, "/api/login")
	api.Attach(&auth.Refresh{
		Datastore: datastore}, "/api/login/refresh")
	api.Attach(&auth.Request{
		SmsVerification: smsVerification,
		Datastore:       datastore}, "/api/login/request")

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
	api.Attach(&subscribe.Sync{
		Datastore: datastore}, "/api/subscribe/sync")
	api.Attach(&subscribe.Import{
		Datastore:   datastore,
		FetchClient: fetch,
		Cachestore:  cachestore}, "/api/subscribe/import")

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
	api.Attach(&listens.Sync{
		Datastore: datastore}, "/api/listens/sync")

	// Users
	api.Attach(&users.List{
		Datastore: datastore}, "/api/users/list")
	api.Attach(&users.Edit{
		Datastore: datastore}, "/api/users/edit")
	api.Attach(&users.Get{
		Datastore: datastore}, "/api/users/get")
	api.Attach(&users.Search{
		Datastore: datastore}, "/api/users/search")
	api.Attach(&users.Top{
		Datastore: datastore}, "/api/users/top")

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

	// Find
	api.Attach(&find.Users{
		Datastore: datastore,
	}, "/api/find/users")

	// Add quick handle for settings
	http.HandleFunc("/features", func(w http.ResponseWriter, r *http.Request) {
		bytes, _ := flags.Print()
		w.Header().Set("Content-Type", "text/plain")
		w.Write(bytes)
	})

	// signout handler
	// http.HandleFunc("/api/signout", func(w http.ResponseWriter, r *http.Request) {
	//  // I don't think this works
	// 	w.Header().Set("Clear-Site-Data", "cookies")
	// })

	log.Info("listening on port " + port + "...")
	log.Error(http.ListenAndServe(":"+port, nil))
}
