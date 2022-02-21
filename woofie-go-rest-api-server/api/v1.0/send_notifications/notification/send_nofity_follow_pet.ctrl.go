package notification

import (
	"encoding/json"
	"fmt"
	"go-woofie-api/database/models"
	"io/ioutil"

	"github.com/gin-gonic/gin"

	"github.com/jinzhu/gorm"
)

// Post type alias
type Follow = models.Follow

// User type alias
type User = models.User
type Pet = models.Pet
type Notification = models.Notification

type SessionVariables struct {
	XHasuraRole   string `json:"x-hasura-role"`
	XHasuraUserId string `json:"x-hasura-user-id"`
}
type Input struct {
	PetId string `json:"pet_id"`
}
type Action struct {
	Name string `json:"name"`
}
type Event struct {
	SessionVariables SessionVariables `json:"session_variables"`
	Data             Data             `json:"data"`
}
type Data struct {
	Old json.RawMessage `json:"old"`
	New json.RawMessage `json:"new"`
}
type Payload struct {
	Event Event `json:"event"`
}
type ResultData struct {
	ID       int
	UserName string
	PetName  string
	UserUUID string
}

func NotifyFollow(c *gin.Context) {
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
	var follow Follow
	errJson = json.Unmarshal(event.Data.New, &follow)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	var resultData ResultData
	result := db.Table("users").Select("users.id,users.name as user_name,users.uuid as user_uuid,pets.name as pet_name").Joins("left join pets on  users.uuid = pets.current_owner_uuid").Where("pets.id =?", follow.PetId).First(&resultData)
	if result.RowsAffected < 1 {
		c.AbortWithStatus(400)
		fmt.Println(result.Error)
		return
	} else {
		var actorUser User
		result = db.Table("users").Where("users.uuid=?", follow.UserUuid).First(&actorUser)
		if result.RowsAffected < 1 {
			c.AbortWithError(400, result.Error)
			return
		}
		if resultData.UserUUID == actorUser.UUID {
			c.JSON(200, gin.H{})
			return
		}
		sendNotifyFollow([]string{resultData.UserUUID}, actorUser, Pet{Name: resultData.PetName})
		notification := Notification{ActorUUID: follow.UserUuid, IsRead: false, OwnerID: resultData.ID, PetID: follow.PetId, Type: 1, OwnerUUID: resultData.UserUUID}
		result = db.Table("notifications").Select("actor_uuid", "is_read", "owner_id", "pet_id", "type", "owner_uuid").Create(&notification)
		if result.RowsAffected >= 1 {
			c.JSON(200, gin.H{})
		} else {
			c.AbortWithStatus(400)
		}
	}
	return
}
