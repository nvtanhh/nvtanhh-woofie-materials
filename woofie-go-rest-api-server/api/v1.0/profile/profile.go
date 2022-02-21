package profile


import (
"github.com/gin-gonic/gin"
)

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	posts := r.Group("/profile")
	{
		posts.POST("/follow", followPet)
	}
}


