package auth

import (
	"fmt"
	"time"

	pb "github.com/dghwood/resonate/proto"
	"github.com/golang-jwt/jwt/v4"
)

// Generate this using rand.Read
var secret = "ThisSecretWhichShouldBeInEnvVar"

type tokenClaims struct {
	UserId string
	jwt.RegisteredClaims
}

func NewTokenClaim(user *pb.UserMessage, expireIn time.Duration) *tokenClaims {
	return &tokenClaims{
		UserId: user.Id,
		RegisteredClaims: jwt.RegisteredClaims{
			IssuedAt: jwt.NewNumericDate(time.Now()),
			// Issued for 24 hours
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(expireIn)),
			Issuer:    "resonate",
		},
	}
}

func GetAccessToken(user *pb.UserMessage, expireIn time.Duration) (accessToken string, err error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, NewTokenClaim(user, expireIn))
	accessToken, err = token.SignedString([]byte(secret))
	return
}

func ValidateAccessToken(accessToken string, user *pb.UserMessage) (err error) {
	claim, err := decodeAccessToken(accessToken)
	if err != nil {
		return
	}
	if claim.UserId != user.Id {
		err = fmt.Errorf("user ID in token does not match provided user ID")
		return
	}
	return
}

func decodeAccessToken(accessToken string) (claim tokenClaims, err error) {
	token, err := jwt.ParseWithClaims(
		accessToken, &claim, func(token *jwt.Token) (any, error) {
			return []byte(secret), nil
		})
	if err != nil {
		return
	}
	if !token.Valid {
		err = fmt.Errorf("token is not valid")
		return
	}
	return
}
