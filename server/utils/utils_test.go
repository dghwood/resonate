package utils

import (
	"testing"
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
