package notify

import (
	"github.com/gin-gonic/gin"
)

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	posts := r.Group("/notify")
	{
		posts.POST("/read-all-notify", ReadAllNotify)
	}
}
