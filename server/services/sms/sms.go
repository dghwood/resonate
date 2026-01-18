package sms

/*
	Verification

Simple interace for phone number verification
*/
type Verification interface {
	Send(phoneNumber string) error
	Validate(phoneNumber string, code string) error
}
