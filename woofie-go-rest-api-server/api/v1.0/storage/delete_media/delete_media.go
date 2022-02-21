package deletemedia

import (
	"context"
	"encoding/json"
	"go-woofie-api/database/models"
	"io/ioutil"
	"net/http"
	"net/url"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"github.com/minio/minio-go/v7"
)

type SessionVariables struct {
	XHasuraRole   string `json:"x-hasura-role"`
	XHasuraUserId string `json:"x-hasura-user-id"`
}
type Input struct {
	PetId string `json:"pet_id"`
}
type Event struct {
	SessionVariables SessionVariables `json:"session_variables"`
	Data             Data             `json:"data"`
}
type Data struct {
	Old json.RawMessage `json:"old"`
	New json.RawMessage `json:"new"`
}
type Payload struct {
	Event Event `json:"event"`
}
type ResultData struct {
	ID       int
	UserName string
	PetName  string
	UserUUID string
}

// Alias
type Media = models.Media
type User = models.User

func DeleteMedia(c *gin.Context) {

	jsonData, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		c.AbortWithStatus(http.StatusBadRequest)
		return
	}

	var objMap map[string]json.RawMessage
	errJson := json.Unmarshal(jsonData, &objMap)
	if errJson != nil {
		c.AbortWithStatus(http.StatusBadRequest)
		return
	}

	var event Event
	errJson = json.Unmarshal(objMap["event"], &event)
	if errJson != nil {
		c.AbortWithStatus(http.StatusBadRequest)
		return
	}
	var media Media
	errJson = json.Unmarshal(event.Data.Old, &media)
	if errJson != nil {
		c.AbortWithStatus(http.StatusBadRequest)
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	var result struct {
		Found bool
	}

	mediaId := media.Id
	db.Raw("SELECT EXISTS(SELECT 1 FROM medias WHERE id = ?) AS found", mediaId).Scan(&result)
	if !result.Found {
		deleteObject(c, media.Url)

		c.AbortWithStatus(http.StatusOK)
	} else {
		c.AbortWithStatus(400)
	}

}

func deleteObject(c *gin.Context, mediaUrl string) {
	ctx := context.Background()

	u, err := url.Parse(mediaUrl)
	if err != nil {
		panic(err)
	}
	path := u.Path
	var bucketName string
	if strings.HasPrefix(path, "/medias") {
		bucketName = "medias"
	}
	if strings.HasPrefix(path, "/avatars") {
		bucketName = "avatars"
	}

	remover := "/" + bucketName + "/"
	objcetName := strings.Replace(path, remover, "", 1)

	opts := minio.RemoveObjectOptions{
		GovernanceBypass: true,
	}

	minioClient := c.MustGet("minio").(*minio.Client)
	err = minioClient.RemoveObject(ctx, bucketName, objcetName, opts)
	if err != nil {
		c.AbortWithStatus(http.StatusPreconditionFailed)
		return
	}
}
