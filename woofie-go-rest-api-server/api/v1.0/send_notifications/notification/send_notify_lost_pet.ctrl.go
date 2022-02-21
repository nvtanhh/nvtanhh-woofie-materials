package notification

import (
	"encoding/json"
	"go-woofie-api/database/models"
	"io/ioutil"

	"github.com/gin-gonic/gin"

	"github.com/jinzhu/gorm"
)

type Location = models.Location

func NotifyLostPet(c *gin.Context) {
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
	var post Post
	errJson = json.Unmarshal(event.Data.New, &post)
	if errJson != nil {
		c.AbortWithStatus(400)
		return
	}
	if post.Type != 3 {
		c.JSON(200, gin.H{})
		return
	}
	db := c.MustGet("db").(*gorm.DB)
	var location Location

	result := db.First(&location, "id = ?", post.LocationId)
	if result.RowsAffected > 0 {
		var pet Pet
		result = db.Table("pets").Joins("join post_pet on pets.id = post_pet.pet_id").Where("post_pet.post_id=?", post.Id).First(&pet)
		if result.RowsAffected > 0 {
			sendNotifyLose(pet, location, post, 2000)
			c.JSON(200, gin.H{})
			return
		} else {
			c.AbortWithStatusJSON(400,map[string]interface{}{"err": "Pet not found"})
			return
		}
	}
	c.AbortWithStatusJSON(400, map[string]interface{}{"err": "Location not found"})
	return
}
