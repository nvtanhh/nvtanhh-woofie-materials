package notification

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"go-woofie-api/database/models"
	"io/ioutil"
)

type RequestContact models.RequestContact

func NotifyNewRequestMessage(c *gin.Context) {
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
	var event Event
	errJson = json.Unmarshal(objMap["event"], &event)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	var requestContact RequestContact
	errJson = json.Unmarshal(event.Data.New, &requestContact)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	var owner User
	result := db.Table("users").Where("users.uuid=?", requestContact.ToUserUUID).First(&owner)
	if result.RowsAffected < 1 {
		c.AbortWithError(400, result.Error)
		return
	}
	sendNewRequestMessage([]string{requestContact.ToUserUUID})
	notification := Notification{ IsRead: false, OwnerID: int(owner.ID),Type: 8, OwnerUUID: owner.UUID}
	result = db.Table("notifications").Select( "is_read", "owner_id", "type", "owner_uuid").Create(&notification)
	if result.RowsAffected >= 1 {
		c.JSON(200, gin.H{})
	} else {
		c.AbortWithStatusJSON(400,result.Error)
	}
	return
}
