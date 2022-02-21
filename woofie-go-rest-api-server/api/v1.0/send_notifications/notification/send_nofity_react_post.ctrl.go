package notification

import (
	"encoding/json"
	"errors"
	"fmt"
	"go-woofie-api/database/models"
	"io/ioutil"

	"github.com/gin-gonic/gin"

	"github.com/jinzhu/gorm"
)

type PostReact = models.PostReact
type Post = models.Post

func NotifyReactPost(c *gin.Context) {
	jsonData, err := ioutil.ReadAll(c.Request.Body)
	if err != nil {
		c.AbortWithError(400,err)
		return
	}
	var objMap map[string]json.RawMessage

	errJson := json.Unmarshal(jsonData, &objMap)
	if errJson != nil {
		c.AbortWithError(400,err)
		return
	}
	var event Event
	errJson = json.Unmarshal(objMap["event"], &event)
	if errJson != nil {
		c.AbortWithError(400,err)
		return
	}
	var postReact PostReact
	errJson = json.Unmarshal(event.Data.New, &postReact)
	if errJson != nil {
		c.AbortWithError(400,err)
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	var resultData ResultData
	result := db.Table("users").Select("users.id,users.name as user_name,users.uuid as user_uuid").Joins("left join posts on  users.uuid = posts.creator_uuid").Where("posts.id =?", postReact.PostID).First(&resultData)
	if result.RowsAffected < 1 {
		c.AbortWithError(400,err)
		fmt.Println(result.Error)
		return
	} else {
		var actorUser User
		result = db.Table("users").Where("users.uuid=?", postReact.ReactorUUID).First(&actorUser)
		if result.RowsAffected < 1 {
			c.AbortWithError(400, result.Error)
			return
		}
		if resultData.UserUUID == actorUser.UUID {
			c.JSON(200, gin.H{})
			return
		}
		notification := Notification{ActorUUID: postReact.ReactorUUID, OwnerID: resultData.ID, PostID: postReact.PostID, Type: 0, OwnerUUID: resultData.UserUUID}
		var notify  Notification
		result = db.Where(notification).First(&notify)
		if result.RowsAffected >= 1 {
			c.JSON(200, gin.H{})
		} else {
			notification.IsRead=false
			result = db.Table("notifications").Select("actor_uuid", "is_read", "owner_id", "post_id", "type", "owner_uuid").Create(&notification)
			if result.RowsAffected >= 1 {
				sendNotifyLike([]string{resultData.UserUUID}, actorUser, Post{Id: uint(postReact.PostID)})
				c.JSON(200, gin.H{})
			} else {
				c.AbortWithError(
					400,
					errors.New("Insert notify Fail"),
				)
			}
		}
	}
	return
}
