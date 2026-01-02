package secrets

import (
	"testing"

	"github.com/dghwood/resonate/constants"
)

func TestSecrets(t *testing.T) {
	err := AccessSecrets(constants.CLOUD_SECRETS_KEY)
	if err != nil {
		t.Error(err)
	}
}
