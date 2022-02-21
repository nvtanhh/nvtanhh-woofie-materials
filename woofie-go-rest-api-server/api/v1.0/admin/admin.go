package admin
import (
	"github.com/gin-gonic/gin"
)

// ApplyRoutes applies router to the gin Engine
func ApplyRoutes(r *gin.RouterGroup) {
	posts := r.Group("/admin")
	{
		posts.POST("/update-user-to-admin", UpdateUserToAdmin)
	}
}
