package memory

import (
	"testing"

	"github.com/dghwood/resonate/services/sms"
)

func TestMemoryVerificationIsVerification(t *testing.T) {
	// Check interface
	var _ sms.Verification = (*MemoryVerification)(nil)
}

func TestSend(t *testing.T) {
	client := NewMemoryVerification()
	phoneNumber := "+15555555555"
	code := "123456"
	err := client.sendWithCode(phoneNumber, code)
	if err != nil {
		t.Error(err)
	}
	err = client.Validate(phoneNumber, "56789")
	if err == nil {
		t.Error("Code should not be valid")
	}
	err = client.Validate(phoneNumber, code)
	if err != nil {
		t.Error(err)
	}
	err = client.Validate(phoneNumber, code)
	if err == nil {
		t.Error("Code should not be valid after validation")
	}
}

func TestValidate(t *testing.T) {
	client := NewMemoryVerification()
	err := client.Validate("+15555555555", "123456")
	if err != nil {
		t.Error(err)
	}
}
