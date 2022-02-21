package send_notifications

import (
	"github.com/gin-gonic/gin"
	"go-woofie-api/api/v1.0/send_notifications/notification"
)

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	posts := r.Group("/notifications")
	{
		posts.POST("/follow", notification.NotifyFollow)
		posts.POST("/like-post", notification.NotifyReactPost)
		posts.POST("/comment", notification.NotifyComment)
		posts.POST("tag-user-comment-post", notification.NotifyTagUserCommentPost)
		posts.POST("/like-comment", notification.NotifyLikeComment)
		posts.POST("/lost-pet", notification.NotifyLostPet)
		posts.POST("/new-request-message", notification.NotifyNewRequestMessage)
	}
}
