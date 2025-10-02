package utils

import (
	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"log"
	"regexp"
)

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
