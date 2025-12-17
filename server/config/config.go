package config

import (
	"flag"
	"os"
)

// Config holds the configuration for the server.
type Config struct {
	Port string
}

// Load loads the configuration from command-line flags and environment variables.
func Load() *Config {
	port := flag.String("port", "8080", "Port to listen on")
	flag.Parse()

	if p := os.Getenv("PORT"); p != "" {
		*port = p
	}

	return &Config{
		Port: *port,
	}
}
