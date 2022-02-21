package notification

import (
	"encoding/json"
	"fmt"
	"go-woofie-api/database/models"
	"io/ioutil"

	"github.com/gin-gonic/gin"

	"github.com/jinzhu/gorm"
)

type Comment = models.Comment

func NotifyComment(c *gin.Context) {
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
	var comment Comment
	errJson = json.Unmarshal(event.Data.New, &comment)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	var resultData ResultData
	result := db.Table("users").Select("users.id,users.name as user_name,users.uuid as user_uuid").Joins("left join posts on  users.uuid = posts.creator_uuid").Where("posts.id =?", comment.PostID).First(&resultData)
	if result.RowsAffected < 1 {
		c.AbortWithStatus(400)
		fmt.Println(result.Error)
		return
	} else {
		var actorUser User
		result = db.Table("users").Where("users.uuid=?", comment.CreatorUUID).First(&actorUser)
		if result.RowsAffected < 1 {
			c.AbortWithError(400, result.Error)
			return
		}
		if resultData.UserUUID == actorUser.UUID {
			c.JSON(200, gin.H{})
			return
		}
		sendNotifyComment([]string{resultData.UserUUID}, actorUser, Post{Id: uint(comment.PostID)})
		notification := Notification{ActorUUID: comment.CreatorUUID, IsRead: false, OwnerID: resultData.ID, PostID: comment.PostID, Type: 2, OwnerUUID: resultData.UserUUID}
		result = db.Table("notifications").Select("actor_uuid", "is_read", "owner_id", "post_id", "type", "owner_uuid").Create(&notification)
		if result.RowsAffected >= 1 {
			c.JSON(200, gin.H{})
		} else {
			c.AbortWithStatus(400)
		}
	}
	return
}
