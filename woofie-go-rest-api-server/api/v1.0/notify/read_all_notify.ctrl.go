package notify

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"go-woofie-api/database/models"
	"io/ioutil"
)

// User type alias
type User = models.User
type SessionVariables struct {
	XHasuraRole   string `json:"x-hasura-role"`
	XHasuraUserId string `json:"x-hasura-user-id"`
}
type Input struct {
	PostId string `json:"post_id"`
}
type Action struct {
	Name string `json:"name"`
}

func ReadAllNotify(c *gin.Context) {
	db := c.MustGet("db").(*gorm.DB)
	jsonData, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		c.AbortWithStatus(400)
		return
	}
	var objMap map[string]json.RawMessage

	errJson := json.Unmarshal(jsonData, &objMap)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	var input Input
	errInput := json.Unmarshal(objMap["input"], &input)
	if errInput != nil {
		c.AbortWithStatus(400)
		return
	}
	var sessionVariables SessionVariables
	errUuid := json.Unmarshal(objMap["session_variables"], &sessionVariables)
	if errUuid != nil {
		c.AbortWithStatus(400)
		return
	}
	result := db.Model(&models.Notification{}).Where("owner_uuid=? AND is_read=?", sessionVariables.XHasuraUserId, false).Update("is_read", true)
	c.JSON(200, gin.H{
		"affectRow": result.RowsAffected,
	})

}
