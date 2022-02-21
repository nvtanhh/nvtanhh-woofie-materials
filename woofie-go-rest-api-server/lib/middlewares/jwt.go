package middlewares

import (
	"context"
	"errors"
	"fmt"
	"os"
	"strings"

	// "go-woofie-api/database/models"

	"go-woofie-api/lib/common"

	"github.com/gin-gonic/gin"

	jwt "github.com/dgrijalva/jwt-go"
	"github.com/lestrrat-go/jwx/jwk"
)

// var secretKey []byte

// func init() {
// 	// get path from root dir
// 	pwd, _ := os.Getwd()
// 	keyPath := pwd + "/jwtsecret.key"

// 	key, readErr := ioutil.ReadFile(keyPath)
// 	if readErr != nil {
// 		panic("failed to load secret key file")
// 	}
// 	secretKey = key
// }

func verify(token *jwt.Token) (interface{}, error) {

	jwksURL := os.Getenv("JWKS_URL")

	set, err := jwk.Fetch(context.Background(), jwksURL)
	if err != nil {
		return nil, err
	}

	keyID, ok := token.Header["kid"].(string)
	if !ok {
		return nil, errors.New("expecting JWT header to have string kid")
	}

	keys, ok := set.LookupKeyID(keyID)
	if !ok {
		return nil, fmt.Errorf("key with specified kid is not present in jwks")
	}
	var publickey interface{}
	err = keys.Raw(&publickey)
	if err != nil {
		return nil, fmt.Errorf("could not parse pubkey")
	}

	return publickey, nil

}

func ValidateToken(tokenString string) (common.JSON, error) {
	token, err := jwt.Parse(tokenString, verify)

	if err != nil {
		return common.JSON{}, err
	}

	if !token.Valid {
		return common.JSON{}, errors.New("invalid token")
	}
	return token.Claims.(jwt.MapClaims), nil
}

func ParseToken(tokenString string) map[string]interface{} {
	token, _ := jwt.Parse(tokenString, nil)
	if token == nil {
		return common.JSON{}
	}
	return token.Claims.(jwt.MapClaims)
}

type UserId struct {
	Data interface{} `json:"data"`
	// more fields with important meta-data about the message...
}

// JWTMiddleware parses JWT token from cookie and stores data and expires date to the context
// JWT Token can be passed as cookie, or Authorization header
func JWTMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString, err := c.Cookie("token")
		// failed to read cookie
		if err != nil {
			// try reading HTTP Header
			authorization := c.Request.Header.Get("Authorization")
			if authorization == "" {
				c.Next()
				return
			}
			sp := strings.Split(authorization, "Bearer ")
			// invalid token
			if len(sp) < 1 {
				c.Next()
				return
			}
			tokenString = sp[1]
		}

		tokenData, err := ValidateToken(tokenString)
		if err != nil {
			c.Next()
			return
		}

		userId := UserId{Data: tokenData["user_id"]}

		c.Set("user_uuid", (userId.Data.(string)))
		c.Next()
	}
}
