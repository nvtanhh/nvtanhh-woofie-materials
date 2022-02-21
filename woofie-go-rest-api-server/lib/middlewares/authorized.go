package middlewares

import "github.com/gin-gonic/gin"

// Authorized blocks unauthorized requestrs
func Authorized(c *gin.Context) {
	userUuid := c.GetString("user_uuid")
	if userUuid == "" {
		c.AbortWithStatus(401)
		return
	}
}
