package deleteobject

import (
	"context"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/minio/minio-go/v7"
)

type Input struct {
	BucketName string `json:"bucketName"`
	FileName   string `json:"fileName"`
}

func DeleteObject(c *gin.Context) {
	ctx := context.Background()

	minioClient := c.MustGet("minio").(*minio.Client)

	jsonData, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": "bad request"})
		return
	}
	var objMap map[string]json.RawMessage
	errJson := json.Unmarshal(jsonData, &objMap)
	if errJson != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": "bad request"})
		return
	}

	var input Input
	errInput := json.Unmarshal(objMap["input"], &input)
	if errInput != nil {
		c.JSON(http.StatusBadRequest, gin.H{"status": "bad request"})
		return
	}

	fileName := input.FileName
	bucketName := input.BucketName

	if !isCanDelete(c, fileName) {
		c.JSON(http.StatusForbidden, gin.H{"status": "You don't have permission to delete."})
		return
	}

	opts := minio.RemoveObjectOptions{
		GovernanceBypass: true,
	}

	err = minioClient.RemoveObject(ctx, bucketName, fileName, opts)
	if err != nil {
		c.JSON(http.StatusPreconditionFailed, gin.H{"status": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "The object had been deleted"})
}

func isCanDelete(c *gin.Context, fileName string) bool {
	userUuid := c.GetString("user_uuid")
	if userUuid == "" {
		return false
	}
	if !strings.Contains(fileName, userUuid) {
		return false
	}
	return true

}
