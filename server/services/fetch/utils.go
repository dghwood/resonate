package fetch

import (
	"bytes"
	"crypto/sha256"
	"encoding/base64"
	"encoding/gob"
	"net/http"
	"strings"

	"github.com/dghwood/resonate/log"
)

func generateKey(request Request) (key string, err error) {

	url := request.Url
	body := request.Body

	bytes := sha256.Sum256([]byte(url + string(body)))
	key = base64.StdEncoding.EncodeToString(bytes[:])
	key = strings.ReplaceAll(key, "/", "_")
	key = strings.ReplaceAll(key, "+", "-")
	log.Info(key)
	return
}

// Generate a string key from a request
func _generateKey(request Request) (key string, err error) {
	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)
	err = enc.Encode(request)
	if err != nil {
		return
	}
	hash := sha256.Sum256(buf.Bytes())
	key = base64.StdEncoding.EncodeToString(hash[:])
	key = strings.ReplaceAll(key, "/", "_")
	key = strings.ReplaceAll(key, "+", "-")
	// key = string(latin1)
	return
}

func addHeaders(req *http.Request, headers map[string]string) {
	req.Header.Add("User-Agent", "resonates.xyz")
	for key, val := range headers {
		req.Header.Add(key, val)
	}
}
