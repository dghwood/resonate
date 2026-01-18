package twilio

import (
	// "fmt"
	"testing"

	"github.com/dghwood/resonate/services/sms"
	// "github.com/joho/godotenv"
)

func TestTwilioVerificationIsVerification(t *testing.T) {
	// Check interface
	var _ sms.Verification = (*TwilioVerification)(nil)
}

func TestValidatePhoneNumber(t *testing.T) {
	phoneNumbers := map[string]bool{
		"12345678":      false,
		"1234567890":    false,
		"+11234567890":  true,
		"+1123456789":   false,
		"+441234567890": true,
		"+44123456789":  false,
	}
	for phoneNumber, isValid := range phoneNumbers {
		err := validatePhoneNumber(phoneNumber)
		if isValid && err != nil {
			t.Error(err)
		}
		if !isValid && err == nil {
			t.Errorf("expected error for %s", phoneNumber)
		}
	}
}

// Commenting these out since they will just fail
// without updating
//
// func TestSend(t *testing.T) {
// 	err := godotenv.Load("/Users/duncan/Code/resonate/server/twilio.test.env")
// 	if err != nil {
// 		t.Fatal("Error loading .env file")
// 	}
// 	// Set the environment variables from
// 	// https://console.twilio.com/ for your test account.

// 	client := NewTwilioVerification()
// 	err = client.Send("+XXXXXXXXX")
// 	if err != nil {
// 		t.Error(err)
// 	}
// }

// func TestValidate(t *testing.T) {
// 	err := godotenv.Load("/Users/duncan/Code/resonate/server/twilio.test.env")
// 	if err != nil {
// 		t.Fatal("Error loading .env file")
// 	}
// 	// Set the environment variables from
// 	// https://console.twilio.com/ for your test account.

// 	client := NewTwilioVerification()
// 	err = client.Validate("+XXXXXXXXXX", "695796")
// 	if err != nil {
// 		t.Error(err)
// 		fmt.Print("something")
// 	}
// }
