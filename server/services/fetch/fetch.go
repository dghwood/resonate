package fetch

import (
	"bytes"
	"io"
	"log"
	"net/http"
	"time"
)

type Client struct {
	client *http.Client
	// cache  *Cachestore
}

func New() Client {
	return Client{
		client: &http.Client{Timeout: 5 * time.Second},
		// cache:  NewCachestore(),
	}
}

type Request struct {
	Url     string
	Body    []byte
	Headers map[string]string
}

func addHeaders(req *http.Request, headers map[string]string) {
	req.Header.Add("User-Agent", "resonates.xyz")
	for key, val := range headers {
		req.Header.Add(key, val)
	}
}

func (c Client) Post(request Request) (resp []byte, err error) {
	req, err := http.NewRequest("POST", request.Url, bytes.NewBuffer(request.Body))
	addHeaders(req, request.Headers)
	if err != nil {
		return
	}
	response, err := c.client.Do(req)
	if err != nil {
		return
	}
	defer response.Body.Close()
	resp, err = io.ReadAll(response.Body)
	return

}

// DONT USE THESE
func (c Client) Get(request Request) (resp []byte, err error) {
	log.Printf("Fetch::Get::%s", request)
	req, err := http.NewRequest("GET", request.Url, nil)
	addHeaders(req, request.Headers)
	if err != nil {
		return
	}
	response, err := c.client.Do(req)
	if err != nil {
		return
	}
	defer response.Body.Close()
	resp, err = io.ReadAll(response.Body)
	return
}

// func (c Client) CachedPost(request Request, ttl time.Duration) (response []byte, err error) {
// 	response, err = c.cache.Get(request, ttl)
// 	if err == nil {
// 		// log.Println("returned from cache")
// 		return
// 	}
// 	response, err = c.Post(request)
// 	if err != nil {
// 		return
// 	}
// 	cacheErr := c.cache.Put(request, response)
// 	if cacheErr != nil {
// 		log.Println(cacheErr)
// 	}
// 	return
// }

// func (c Client) CachedGet(request Request, ttl time.Duration) (response []byte, err error) {
// 	response, err = c.cache.Get(request, ttl)
// 	if err == nil {
// 		log.Println("returned from cache")
// 		return
// 	}
// 	response, err = c.Get(request)
// 	if err != nil {
// 		return
// 	}
// 	cacheErr := c.cache.Put(request, response)
// 	if cacheErr != nil {
// 		log.Println(cacheErr)
// 	}
// 	return
// }
