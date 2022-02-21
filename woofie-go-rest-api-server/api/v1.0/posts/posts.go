package posts

import (
	"go-woofie-api/lib/middlewares"

	"github.com/gin-gonic/gin"
)

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	posts := r.Group("/posts")
	{
		posts.POST("/edit-post", middlewares.Authorized, edit)
	}
}
