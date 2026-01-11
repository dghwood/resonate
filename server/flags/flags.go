/*
	Flags

I've gone back and forth on this, but I think the best way
to implement this is via environment variables.

Note: **SECRETS** are put in the secret manager

This file is for feature flags.
*/
package flags

import (
	"os"

	yaml "gopkg.in/yaml.v3"
)

type Flags struct {
	EnableSms bool
}

var FLAGS = Flags{}

func Parse() {
	// Load up environment variables
	FLAGS.EnableSms = os.Getenv("ENABLE_SMS") == "1"
}

func Print() (bytes []byte, err error) {
	return yaml.Marshal(&FLAGS)
}
