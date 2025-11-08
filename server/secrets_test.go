package main

import (
	"testing"
)

func TestSecrets(t *testing.T) {
	err := AccessSecrets()
	if err != nil {
		t.Error(err)
	}
}
