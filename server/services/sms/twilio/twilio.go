package twilio

import (
	"fmt"
	"os"

	"github.com/dghwood/resonate/errors"
	"github.com/dghwood/resonate/log"
	"github.com/twilio/twilio-go"
	twilioClient "github.com/twilio/twilio-go/client"
	verify "github.com/twilio/twilio-go/rest/verify/v2"
)

type TwilioVerification struct {
	serviceSID string
}

func (t *TwilioVerification) Send(phoneNumber string) (err error) {
	err = validatePhoneNumber(phoneNumber)
	if err != nil {
		return
	}
	client := twilio.NewRestClient()
	params := &verify.CreateVerificationParams{}
	params.SetTo(phoneNumber)
	params.SetChannel("sms")
	// The code generated is defined by twilio,
	// I can only configure how long it is
	// 6 characters currently
	resp, err := client.VerifyV2.CreateVerification(t.serviceSID, params)
	if err != nil {
		err = mapTwilioError(err)
		log.Error(err)
		return
	}
	if *resp.Status == "pending" {
		// Pending seems to be the right status
		// to check for
		return
	}
	return fmt.Errorf("error: %s", *resp.Status)
}

func mapTwilioError(err error) (mappedErr error) {
	twilioErr, ok := err.(*twilioClient.TwilioRestError)
	if !ok {
		log.Error("failed to map error", err)
		return err
	}
	switch twilioErr.Code {
	case 20404: // 404
		return errors.ERROR_TIME_EXPIRED
	case 60202: // Max 5 attempts
		return errors.ERROR_TOO_MANY_ATTEMPTS
	}
	return err
}

func validatePhoneNumber(phoneNumber string) (err error) {
	if phoneNumber[:1] != "+" {
		return fmt.Errorf("invalid phone number: %s", phoneNumber)
	}
	if phoneNumber[:3] == "+44" {
		// UK Number
		if len(phoneNumber) != 3+10 {
			return fmt.Errorf("invalid UK phone number: %s", phoneNumber)
		}
		return
	}
	if phoneNumber[:2] == "+1" {
		// US Number
		if len(phoneNumber) != 2+10 {
			return fmt.Errorf("invalid US phone number: %s", phoneNumber)
		}
		return
	}
	return fmt.Errorf("invalid phone number: %s", phoneNumber)
}

func (t *TwilioVerification) Validate(
	phoneNumber string, code string) (err error) {
	err = validatePhoneNumber(phoneNumber)
	if err != nil {
		return
	}
	client := twilio.NewRestClient()

	params := &verify.CreateVerificationCheckParams{}
	params.SetTo(phoneNumber)
	params.SetCode(code)

	resp, err := client.VerifyV2.CreateVerificationCheck(t.serviceSID, params)
	if err != nil {
		err = mapTwilioError(err)
		log.Error(err)
		return
	}
	if *resp.Status == "approved" {
		// It won't be approved if the code was incorrect.
		return
	}
	// TODO(duncan): Better handling of error codes
	return errors.ERROR_INVALID_CREDENTIALS
}

func NewTwilioVerification() *TwilioVerification {
	if _, ok := os.LookupEnv("TWILIO_ACCOUNT_SID"); !ok {
		panic("TWILIO_ACCOUNT_SID not set")
	}
	if _, ok := os.LookupEnv("TWILIO_AUTH_TOKEN"); !ok {
		panic("TWILIO_AUTH_TOKEN not set")
	}
	if _, ok := os.LookupEnv("TWILIO_SERVICE_SID"); !ok {
		panic("TWILIO_SERVICE_SID not set")
	}
	return &TwilioVerification{
		serviceSID: os.Getenv("TWILIO_SERVICE_SID"),
	}
}
