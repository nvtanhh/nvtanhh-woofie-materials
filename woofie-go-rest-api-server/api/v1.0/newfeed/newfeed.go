package newfeed

import (
	"github.com/gin-gonic/gin"
)

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	posts := r.Group("/newfeed")
	{
		posts.POST("/like-post", likePost)
		posts.POST("/like-comment", likeComment)
		posts.POST("/all-user-in-post", getAllUserInPost)
	}
}
