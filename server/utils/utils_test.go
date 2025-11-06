package utils

import (
	"testing"
	"time"
)

func TestIsValidEmail(t *testing.T) {
	emails := map[string]bool{
		"something@else.com":       true,
		"something+else@gmail.com": true,
		"somethingelse.com":        false,
	}

	for email, expected := range emails {
		if IsValidEmail(email) != expected {
			t.Errorf("Expected %s to be valid: %v", email, expected)
		}
	}
}

func TestIsValidPhoneNumber(t *testing.T) {
	phoneNumbers := map[string]bool{
		"1234567890":     true,
		"+1234567890":    true,
		"123-456-7890":   true,
		"(123) 456-7890": true,
		" 123456789":     true,
	}
	for phoneNumber, expected := range phoneNumbers {
		if IsValidPhoneNumber(phoneNumber) != expected {
			t.Errorf("Expected %s to be valid: %v", phoneNumber, expected)
		}
	}
}

func TestTimestampDelta(t *testing.T) {
	now := time.Now()
	later := now.Add(15 * time.Hour)
	delta := TimestampDelta(ToTimestamp(now), ToTimestamp(later))

	if delta.Hours() != 15 {
		t.Errorf("Expected delta to be 15 hours, got %v", delta)
	}
	if delta.Minutes()-15*60 != 0 {
		t.Errorf("Expected delta to be 0 minutes, got %v", delta)
	}

}
