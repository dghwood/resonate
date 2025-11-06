package utils

import (
	"crypto/hmac"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"fmt"
	"log"
	"os"
	"regexp"
	"time"
)

/*
	Timestamp Functions

I need to centralize the definition of timestamp across
the code base.

TODO(duncan): Figure out what to standardize on.
*/
func ToTimestamp(timestamp time.Time) int64 {
	return timestamp.UTC().Unix()
}
func FromTimestamp(timestamp int64) time.Time {
	return time.Unix(timestamp, 0).UTC()
}
func Now() int64 {
	// TODO(duncan): Should this be seconds / milliseconds?
	return ToTimestamp(time.Now())
}
func TimestampDelta(before int64, after int64) time.Duration {
	return FromTimestamp(after).Sub(FromTimestamp(before))
}

// isValidEmail checks if the provided email has a valid format
func IsValidEmail(email string) bool {
	// https://stackoverflow.com/questions/48055431/can-it-cause-harm-to-validate-email-addresses-with-a-regex
	const emailRegex = `^.+@.+\..+$`
	re := regexp.MustCompile(emailRegex)
	return re.MatchString(email)
}

func GenerateRandomNumberString(length int) string {
	const charset = "0123456789"
	l := len(charset)
	b := make([]byte, length)
	_, err := rand.Read(b)
	if err != nil {
		log.Println("Error generating random number:", err)
		return ""
	}
	for i := range b {
		b[i] = charset[int(b[i])%l]
	}
	return string(b)
}

func IsValidPhoneNumber(phoneNumber string) bool {
	// TODO(duncan)
	// This is a very basic regex for demonstration purposes.
	// A more robust solution would involve a dedicated phone number validation library
	// or a more comprehensive regex that accounts for international formats.
	// This regex checks for 9-digit numbers, optionally starting with a '+',
	// and allowing spaces, hyphens, or parentheses.
	match, _ := regexp.MatchString(`^\+?[\d\s\-\(\)]{10,15}$`, phoneNumber)
	return match
}

func HashString(s string) string {
	// TODO(duncan): Is this the right hash function
	return fmt.Sprintf("%x", sha256.Sum256([]byte(s)))
}

func HashPhoneNumber(phoneNumber string) string {
	key := []byte(os.Getenv("USER_ID_SALT"))
	h := hmac.New(sha256.New, key)
	h.Write([]byte(phoneNumber))
	return hex.EncodeToString(h.Sum(nil))
}

// GenerateUniqueID generates a random 32-character hexadecimal string.
func GenerateUniqueID() string {
	bytes := make([]byte, 16)
	_, err := rand.Read(bytes)
	if err != nil {
		log.Println("Error generating unique ID:", err)
		return ""
	}
	return hex.EncodeToString(bytes)
}

func Base64Encode(s string) string {
	return base64.StdEncoding.EncodeToString([]byte(s))
}

func Base64Decode(s string) (string, error) {
	data, err := base64.StdEncoding.DecodeString(s)
	if err != nil {
		log.Println("Error decoding base64 string:", err)
		return "", err
	}
	return string(data), nil
}
