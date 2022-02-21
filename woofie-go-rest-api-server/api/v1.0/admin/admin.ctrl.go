package admin

import (
	"context"
	"encoding/json"
	firebase "firebase.google.com/go/v4"
	"fmt"
	"github.com/gin-gonic/gin"
	"google.golang.org/api/option"
	"io/ioutil"
	"log"
	"strings"

	//"strconv"
)

func UpdateUserToAdmin(c *gin.Context) {
	jsonData, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		c.AbortWithStatus(400)
		return
	}
	var objMap map[string]json.RawMessage

	errJson := json.Unmarshal(jsonData, &objMap)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	uid := strings.Replace(string(objMap["uid"]),"\"","",-1)
	if len(uid) == 0 {
		c.AbortWithStatus(400)
		return
	}
	opt := option.WithCredentialsFile("meowoof-da693-firebase-adminsdk-lnntr-11901c0e13.json")
	config := &firebase.Config{ProjectID: "meowoof-da693"}
	app, err := firebase.NewApp(context.Background(), config, opt)
	if err != nil {
		fmt.Errorf("error initializing app: %v", err)
		c.AbortWithError(400, err)
		return
	}
	client, err := app.Auth(context.Background())
	if err != nil {
		fmt.Errorf("error initializing app: %v", err)
		c.AbortWithError(400, err)
		return
	}
	claims := map[string]interface{}{
		"https://hasura.io/jwt/claims": map[string]interface{}{
			"x-hasura-default-role":  "admin",
			"x-hasura-allowed-roles": []string{"user", "admin"},
			"x-hasura-user-id":       uid, // user.uid,
		},
	}
	err = client.SetCustomUserClaims(context.Background(), uid, claims)
	if err != nil {
		log.Fatalf("error setting custom claims %v\n", err)
		c.AbortWithError(400, err)
		return
	}
	c.JSON(200, gin.H{})
}
