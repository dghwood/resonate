package auth

import (
	"testing"
	"time"

	"github.com/dghwood/resonate/models"
	datastoreService "github.com/dghwood/resonate/services/datastore/firestore"
)

func TestRefreshTokensGet(t *testing.T) {
	var projectID = "level-prism-477102-p5"
	var databaseId = "rxyz-db-test"
	datastore := datastoreService.NewFirestoreDatastore(projectID, databaseId)
	refreshTokenString := "CiA5YzIwMTUzOTk3NGUyMWUzYzI2YThjYjE1MWZlYTRmMhD9j+DYBg=="

	refreshToken := models.NewToken()
	refreshToken.FromTokenString(refreshTokenString)

	tokens := models.RefreshTokens{}
	tokens.UserId = "6a4c9ded42a558b2854648fea3f49872"
	err := datastore.Get(&tokens)
	if err != nil {
		t.Error(err)
	}
	// Check the refresh token
	if len(tokens.Tokens) == 0 {
		t.Error("no tokens")
	}
	isTokenGood := false
	for _, token := range tokens.Tokens {
		// t.Error(token.Token)
		if token.Token == refreshToken.Token {
			t.Error(time.Now().UTC().Unix(), "-", token.ExpiryUtcTimestamp)
			isTokenGood = true
			break
		}
	}
	if !isTokenGood {
		t.Error("token no good")
	}
	// for _, token := range tokens.Tokens {
	// 	if token.Token == refreshToken.Token &&
	// 		refreshToken.ExpiryUtcTimestamp < time.Now().UTC().Unix() {

	// 		break
	// 	}
	// }
}
