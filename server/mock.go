package main

import (
	"fmt"
	"math/rand"
	"os"
	"time"

	podcastService "github.com/dghwood/resonate/api/podcast"
	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/models"
	"github.com/dghwood/resonate/services/datastore"
	"github.com/dghwood/resonate/services/fetch"
	"github.com/dghwood/resonate/services/imagestore"
)

func mockUser(phoneNumber string, name string, imageUrl string) *models.User {
	user := models.User{}
	user.SetIdFromPhoneNumber(phoneNumber)
	user.Name = name
	user.ImageUrl = imageUrl
	return &user
}

func readProfileImage() ([]byte, error) {
	imagePath := "./profile.jpg"
	imageBytes, err := os.ReadFile(imagePath)
	if err != nil {
		return nil, fmt.Errorf("failed to read profile image: %w", err)
	}
	return imageBytes, nil
}

func NewMockDatastore(f *fetch.Client, is imagestore.Imagestore) *datastore.MemoryDatastore {
	ds := datastore.NewMemoryDatastore()

	// Add a fake profile image
	imageBytes, err := readProfileImage()
	if err != nil {
		panic(err)
	}
	imageId := "stock"
	err = is.Put(imageId, imageBytes)
	if err != nil {
		panic(err)
	}
	profileImageUrl := "/images/users/" + imageId

	// add some users
	phoneNumbers := []string{
		"1111111111",
		"2222222222",
		"3333333333",
	}
	users := make([]*models.User, len(phoneNumbers))
	for i, phoneNumber := range phoneNumbers {
		users[i] = mockUser(
			phoneNumber,
			fmt.Sprintf("User %d", i),
			profileImageUrl)
	}
	err = ds.PutMulti(users)
	if err != nil {
		panic(err)
	}

	// Follow each other
	for i := range len(users) {
		for j := range len(users) {
			if i == j {
				continue
			}
			follow := models.Follow{}
			follow.Id = fmt.Sprintf("%s-%s", users[i].Id, users[j].Id)
			follow.UserId = users[i].Id
			follow.FollowUtcTimestampMs = time.Now().UTC().UnixMilli()
			follow.FollowedUserId = users[j].Id
			ds.Put(&follow)
		}
	}
	// Add some podcasts (these are real)
	podcastUrls := []string{
		"https://feeds.simplecast.com/dxZsm5kX", // Pod Save America
		// "https://feeds.npr.org/510310/podcast.xml", // NPR Politics
		"https://feeds.simplecast.com/jZLi00b4", // What Trump can teach
		// "https://feeds.simplecast.com/6HKOhNgS",    // Hardfork
	}

	podcastApi := podcastService.List{
		Datastore:   ds,
		FetchClient: f,
	}

	for _, url := range podcastUrls {
		request := podcastApi.RequestProto()
		response := podcastApi.ResponseProto()
		podcast := models.Podcast{}
		podcast.SetIdFromUrl(url)
		request.PodcastId = podcast.Id
		err := podcastApi.Execute(nil,
			request,
			response)
		if err != nil {
			panic(err)
		}

		// Subscribe the users
		for _, user := range users {
			subscribe := models.Subscription{}
			subscribe.Id = fmt.Sprintf("%s-%s", user.Id, podcast.Id)
			subscribe.UserId = user.Id
			subscribe.PodcastId = podcast.Id
			err = ds.Put(&subscribe)
			if err != nil {
				panic(err)
			}
		}

		// Add some listens
		for _, user := range users {
			for _, episode := range response.Episodes {
				if rand.Intn(5) == 0 { // Randomly select some episodes
					log.Infof("Adding listen for user %s to episode %s", user.Id, episode.Title)
					listen := models.Listen{}
					listen.Id = fmt.Sprintf("%s-%s", user.Id, episode.Id)
					listen.UserId = user.Id
					listen.EpisodeId = episode.Id
					listen.ListenTimestamp = episode.PublishTimestamp
					err = ds.Put(&listen)
					if err != nil {
						panic(err)
					}
				}
			}
		}

	}

	return ds
}
