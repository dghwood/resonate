package auth

import (
	"testing"
	"time"

	// "github.com/dghwood/resonate/server/errors"

	"github.com/dghwood/resonate/server/errors"
	pb "github.com/dghwood/resonate/server/proto"
)

func TestGetAccessToken(t *testing.T) {
	user := &pb.UserMessage{
		Id:   "test-user-id",
		Name: "Test User",
	}
	accessToken, err := GetAccessToken(user, 1*time.Hour)
	// t.Error(accessToken)
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

func TestExpiredAccessTokenUser(t *testing.T) {
	user := &pb.UserMessage{
		Id:   "test-user-id",
		Name: "Test User",
	}
	accessToken, err := GetAccessToken(user, -1*time.Hour)
	if err != nil {
		t.Fatalf("Failed to get access token: %v", err)
	}

	_, err = ValidUserIdFromToken(accessToken)
	if err == nil {
		t.Error("Token should error")
	}

	if !errors.Is(err, errors.ERROR_TIME_EXPIRED) {
		t.Error("Error should be ERROR_TIME_EXPIRED")
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
