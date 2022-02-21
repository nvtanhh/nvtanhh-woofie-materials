package storage

import (
	deletemedia "go-woofie-api/api/v1.0/storage/delete_media"
	deleteobject "go-woofie-api/api/v1.0/storage/delete_object"
	presignedurl "go-woofie-api/api/v1.0/storage/presigned_url"
	"go-woofie-api/lib/middlewares"

	"github.com/gin-gonic/gin"
)

func ApplyRoutes(r *gin.RouterGroup) {
	storage := r.Group("/storage")
	{
		storage.POST("/get-presigned-url", middlewares.Authorized, presignedurl.GetPresignedPutObjectUrl)
		storage.POST("/delete-object", middlewares.Authorized, deleteobject.DeleteObject)
		storage.POST("/delete-media", deletemedia.DeleteMedia)
	}
}
