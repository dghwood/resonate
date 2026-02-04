package secrets

import (
	"context"
	"encoding/json"
	"fmt"
	"hash/crc32"
	"os"

	secretmanager "cloud.google.com/go/secretmanager/apiv1"
	"cloud.google.com/go/secretmanager/apiv1/secretmanagerpb"
)

type Secrets struct {
	TADDY_API_KEY      string `json:"TADDY_API_KEY"`
	USER_ID_SALT       string `json:"USER_ID_SALT"`
	TADDY_USER_ID      string `json:"TADDY_USER_ID"`
	TWILIO_ACCOUNT_SID string `json:"TWILIO_ACCOUNT_SID"`
	TWILIO_AUTH_TOKEN  string `json:"TWILIO_AUTH_TOKEN"`
	TWILIO_SERVICE_SID string `json:"TWILIO_SERVICE_SID"`
}

func AccessSecrets(version string) (err error) {
	name := version

	// Create the client.
	ctx := context.Background()
	client, err := secretmanager.NewClient(ctx)
	if err != nil {
		return
	}
	defer client.Close()

	// Build the request.
	req := &secretmanagerpb.AccessSecretVersionRequest{
		Name: name,
	}

	// Call the API.
	result, err := client.AccessSecretVersion(ctx, req)
	if err != nil {
		return
	}

	// Verify the data checksum.
	crc32c := crc32.MakeTable(crc32.Castagnoli)
	checksum := int64(crc32.Checksum(result.Payload.Data, crc32c))
	if checksum != *result.Payload.DataCrc32C {
		return fmt.Errorf("data corruption detected")
	}

	// WARNING: Do not print the secret in a production environment - this snippet
	// is showing how to access the secret material.
	// fmt.Fprintf(w, "Plaintext: %s\n", string(result.Payload.Data))
	secrets := &Secrets{}
	if err := json.Unmarshal(result.Payload.Data, secrets); err != nil {
		return err
	}

	os.Setenv("TADDY_API_KEY", secrets.TADDY_API_KEY)
	os.Setenv("USER_ID_SALT", secrets.USER_ID_SALT)
	os.Setenv("TADDY_USER_ID", secrets.TADDY_USER_ID)
	os.Setenv("TWILIO_ACCOUNT_SID", secrets.TWILIO_ACCOUNT_SID)
	os.Setenv("TWILIO_AUTH_TOKEN", secrets.TWILIO_AUTH_TOKEN)
	os.Setenv("TWILIO_SERVICE_SID", secrets.TWILIO_SERVICE_SID)

	return nil
}
