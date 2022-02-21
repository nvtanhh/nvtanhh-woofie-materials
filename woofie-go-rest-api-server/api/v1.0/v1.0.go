package apiv1

import (
	"go-woofie-api/api/v1.0/admin"
	"go-woofie-api/api/v1.0/newfeed"
	"go-woofie-api/api/v1.0/notify"
	"go-woofie-api/api/v1.0/posts"
	"go-woofie-api/api/v1.0/profile"
	"go-woofie-api/api/v1.0/send_notifications"
	"go-woofie-api/api/v1.0/storage"

	"github.com/gin-gonic/gin"
)

func ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	v1 := r.Group("/v1.0")
	{
		v1.GET("/ping", ping)

		storage.ApplyRoutes(v1)
		profile.ApplyRoutes(v1)
		newfeed.ApplyRoutes(v1)
		send_notifications.ApplyRoutes(v1)
		notify.ApplyRoutes(v1)
		posts.ApplyRoutes(v1)
		admin.ApplyRoutes(v1)
	}
}
