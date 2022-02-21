package miniostorage

import (
	"github.com/gin-gonic/gin"
	"github.com/minio/minio-go/v7"
)

// Inject injects database to gin context
func Inject(minioClient *minio.Client) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Set("minio", minioClient)
		c.Next()
	}
}
