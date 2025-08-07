package auth

import (
	"testing"
	"time"

	pb "github.com/dghwood/resonate/proto"
)

func TestGetAccessToken(t *testing.T) {
	user := &pb.UserMessage{
		Id:   "test-user-id",
		Name: "Test User",
	}
	accessToken, err := GetAccessToken(user, 1*time.Hour)
	if err != nil {
		t.Fatalf("Failed to get access token: %v", err)
	}

	err = ValidateAccessToken(accessToken, user)
	if err != nil {
		t.Fatalf("Failed to validate access token: %v", err)
	}
}

func TestExpiredAccessToken(t *testing.T) {
	user := &pb.UserMessage{
		Id:   "test-user-id",
		Name: "Test User",
	}
	accessToken, err := GetAccessToken(user, -1*time.Hour)
	if err != nil {
		t.Fatalf("Failed to get access token: %v", err)
	}
	err = ValidateAccessToken(accessToken, user)
	if err == nil {
		t.Fatalf("Failed to validate access token: %v", err)
	}
}

func TestWrongUserAccessToken(t *testing.T) {
	user := &pb.UserMessage{
		Id:   "test-user-id",
		Name: "Test User",
	}
	accessToken, err := GetAccessToken(user, 1*time.Hour)
	if err != nil {
		t.Fatalf("Failed to get access token: %v", err)
	}
	err = ValidateAccessToken(accessToken, &pb.UserMessage{
		Id: "wrong-user-id",
	})
	t.Error(err)
	if err == nil {
		t.Fatalf("Failed to validate access token: %v", err)
	}
}
