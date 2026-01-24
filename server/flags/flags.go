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
	"strconv"

	yaml "gopkg.in/yaml.v3"
)

type Flags struct {
	EnableSms                     bool
	LowestCompatibleClientVersion int
	CloudProjectId                string
	CloudDatabaseId               string
	CloudStorageBucketCache       string
	CloudStorageBucketImages      string
	CloudSecretsKey               string
}

var FLAGS = Flags{}

func GetStringEnv(key string, defaultValue string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return defaultValue
}

func RequireStringEnv(key string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	panic("Missing required environment variable: " + key)
}

func GetBoolEnv(key string, defaultValue bool) bool {
	if value, ok := os.LookupEnv(key); ok {
		if value != "1" && value != "0" {
			return defaultValue
		}
		return value == "1"
	}
	return defaultValue
}

func RequireBoolEnv(key string) bool {
	if value, ok := os.LookupEnv(key); ok {
		if value != "1" && value != "0" {
			panic("Invalid boolean value for environment variable: " + key)
		}
		return value == "1"
	}
	panic("Missing required environment variable: " + key)
}

func GetIntEnv(key string, defaultValue int) int {
	if value, ok := os.LookupEnv(key); ok {
		num, err := strconv.Atoi(value)
		if err != nil {
			return defaultValue
		}
		return num
	}
	return defaultValue
}

func RequireIntEnv(key string) int {
	if value, ok := os.LookupEnv(key); ok {
		num, err := strconv.Atoi(value)
		if err != nil {
			panic("Invalid integer value for environment variable: " + key)
		}
		return num
	}
	panic("Missing required environment variable: " + key)
}

func Parse() {
	// Load up environment variables
	FLAGS.EnableSms = GetBoolEnv("ENABLE_SMS", false)
	FLAGS.LowestCompatibleClientVersion = GetIntEnv("LOWEST_COMPATIBLE_CLIENT_VERSION", -1)
	FLAGS.CloudProjectId = RequireStringEnv("CLOUD_PROJECT_ID")
	FLAGS.CloudDatabaseId = RequireStringEnv("CLOUD_DATABASE_ID")
	FLAGS.CloudStorageBucketCache = RequireStringEnv("CLOUD_STORAGE_BUCKET_CACHE")
	FLAGS.CloudStorageBucketImages = RequireStringEnv("CLOUD_STORAGE_BUCKET_IMAGES")
	FLAGS.CloudSecretsKey = RequireStringEnv("CLOUD_SECRETS_KEY")
}

func Print() (bytes []byte, err error) {
	return yaml.Marshal(&FLAGS)
}
