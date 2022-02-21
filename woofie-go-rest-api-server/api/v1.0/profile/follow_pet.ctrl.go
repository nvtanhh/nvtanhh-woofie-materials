package profile

import (
	"encoding/json"
	"github.com/jinzhu/gorm"
	"go-woofie-api/database/models"
	"io/ioutil"
	"strconv"

	"github.com/gin-gonic/gin"
	//"strconv"
)

// Post type alias
type Follow = models.Follow

// User type alias
type User = models.User
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

func followPet(c *gin.Context) {
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
	var follows []Follow
	db.Table("follows").Where("user_uuid = ? AND pet_id=?", sessionVariables.XHasuraUserId, input.PetId).Find(&follows)
	if len(follows) >= 1 {
		db.Table("follows").Delete(&follows[0])
	} else {
		intVar, _ := strconv.Atoi(input.PetId)
		follow := Follow{PetId: intVar, UserUuid: sessionVariables.XHasuraUserId}
		db.Table("follows").Create(&follow)
		c.JSON(200, gin.H{
			"id": follow.ID,
		})
		return
	}
	c.JSON(200, gin.H{
		"id": 0,
	})
}
