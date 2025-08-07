package utils

import "regexp"

// isValidEmail checks if the provided email has a valid format
func isValidEmail(email string) bool {
	// https://stackoverflow.com/questions/48055431/can-it-cause-harm-to-validate-email-addresses-with-a-regex
	const emailRegex = `^.+@.+\..+$`
	re := regexp.MustCompile(emailRegex)
	return re.MatchString(email)
}
