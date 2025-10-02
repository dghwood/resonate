package fetch

import (
	"bytes"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/dghwood/resonate/log"
	"github.com/dghwood/resonate/services/cachestore"
)

type Request struct {
	Url      string
	Body     []byte
	Headers  map[string]string
	CacheTtl time.Duration
}

type Client struct {
	client     *http.Client
	cachestore cachestore.Cachestore
}

func New() *Client {
	return &Client{
		client:     &http.Client{Timeout: 5 * time.Second},
		cachestore: nil,
	}
}

func NewCached(store cachestore.Cachestore) *Client {
	return &Client{
		client:     &http.Client{Timeout: 5 * time.Second},
		cachestore: store,
	}
}

func (c *Client) Get(request Request) (resp []byte, err error) {
	if c.cachestore == nil {
		return c.get(request)
	}
	cacheKey, err := generateKey(request)
	if err != nil {
		return
	}
	if request.CacheTtl > 0 {
		resp, err = c.cachestore.Get(cacheKey, request.CacheTtl)
		if err == nil {
			return
		}
	}
	resp, err = c.get(request)
	if err != nil {
		return
	}
	cacheErr := c.cachestore.Put(cacheKey, resp)
	if cacheErr != nil {
		log.Errorf("Cache failed to put %s", cacheErr)
	}
	return
}

func (c *Client) Post(request Request) (resp []byte, err error) {
	log.Info("POST:", request)
	if c.cachestore == nil {
		return c.post(request)
	}
	cacheKey, err := generateKey(request)
	if err != nil {
		return
	}
	if request.CacheTtl > 0 {
		resp, err = c.cachestore.Get(cacheKey, request.CacheTtl)
		if err == nil {
			return
		}
	}
	resp, err = c.post(request)
	if err != nil {
		return
	}
	cacheErr := c.cachestore.Put(cacheKey, resp)
	if cacheErr != nil {
		log.Errorf("Cache failed to put %s", cacheErr)
	}
	return
}

func (c *Client) post(request Request) (resp []byte, err error) {

	req, err := http.NewRequest("POST", request.Url, bytes.NewBuffer(request.Body))
	addHeaders(req, request.Headers)
	if err != nil {
		return
	}
	if c.client == nil {
		err = fmt.Errorf("client is nil")
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

func (c *Client) get(request Request) (resp []byte, err error) {
	log.Infof("Fetch::Get::%s", request)
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
