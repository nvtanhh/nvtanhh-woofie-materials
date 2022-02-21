package notification

import (
	"encoding/json"
	"fmt"
	"go-woofie-api/database/models"
	"io/ioutil"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

type CommentTagUser = models.CommentTagUser

func NotifyTagUserCommentPost(c *gin.Context) {
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
	var commentTagUser CommentTagUser
	errJson = json.Unmarshal(event.Data.New, &commentTagUser)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	var actorUser User
	result := db.Table("users").Joins("left join comments on  users.uuid = comments.creator_uuid").Where("comments.id =?", commentTagUser.CommentID).First(&actorUser)
	if result.RowsAffected < 1 {
		c.AbortWithStatus(400)
		fmt.Println(result.Error)
		return
	} else {
		var ownerUser User
		result = db.Table("users").Where("users.id=?", commentTagUser.UserID).First(&ownerUser)
		if result.RowsAffected < 1 {
			c.AbortWithError(400, result.Error)
			return
		}
		if ownerUser.UUID == actorUser.UUID {
			c.JSON(200, gin.H{})
			return
		}
		sendNotifyCommentTagUser([]string{ownerUser.UUID}, actorUser, Post{Id: uint(commentTagUser.PostID)})
		notification := Notification{ActorUUID: actorUser.UUID, IsRead: false, OwnerID: int(ownerUser.ID), PostID: commentTagUser.PostID, Type: 6, OwnerUUID: ownerUser.UUID}
		result = db.Table("notifications").Select("actor_uuid", "is_read", "owner_id", "post_id", "type", "owner_uuid").Create(&notification)
		if result.RowsAffected >= 1 {
			c.JSON(200, gin.H{})
		} else {
			c.AbortWithStatus(400)
		}
	}
	return
}
