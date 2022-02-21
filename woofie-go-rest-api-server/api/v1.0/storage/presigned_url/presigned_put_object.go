package presignedurl

import (
	"context"
	"encoding/json"
	"io/ioutil"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/minio/minio-go/v7"
)

type Input struct {
	BucketName string `json:"bucketName"`
	FileName   string `json:"fileName"`
}

func GetPresignedPutObjectUrl(c *gin.Context) {
	ctx := context.Background()

	minioClient := c.MustGet("minio").(*minio.Client)

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

	var input Input
	errInput := json.Unmarshal(objMap["input"], &input)
	if errInput != nil {
		c.AbortWithStatus(400)
		return
	}

	fileName := input.FileName
	bucketName := input.BucketName
	presignedURL, err := minioClient.PresignedPutObject(ctx, bucketName, fileName, time.Duration(1000)*time.Second)
	if err != nil {
		c.JSON(404, gin.H{"error": err.Error()})
		return
	}

	url := gin.H{"url": presignedURL.String()}
	c.JSON(200, url)
}
