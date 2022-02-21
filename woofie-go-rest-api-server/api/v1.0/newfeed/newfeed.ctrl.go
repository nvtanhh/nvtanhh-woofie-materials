package newfeed

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"go-woofie-api/database/models"
	"io/ioutil"
	//"strconv"
)

// Post type alias
type PostReact = models.PostReact
type CommentReact = models.CommentReact

// User type alias
type User = models.User
type SessionVariables struct {
	XHasuraRole   string `json:"x-hasura-role"`
	XHasuraUserId string `json:"x-hasura-user-id"`
}
type Input struct {
	PostId    int `json:"post_id"`
	CommentId int `json:"comment_id"`
}
type Action struct {
	Name string `json:"name"`
}

func likePost(c *gin.Context) {
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
	var follows []PostReact
	db.Table("post_reacts").Where("reactor_uuid = ? AND post_id=?", sessionVariables.XHasuraUserId, input.PostId).Find(&follows)
	if len(follows) >= 1 {
		db.Table("post_reacts").Delete(&follows[0])
	} else {
		postReact := PostReact{PostID: input.PostId, ReactorUUID: sessionVariables.XHasuraUserId}
		if errCreate := db.Table("post_reacts").Create(&postReact).Error; errCreate != nil {
			c.JSON(400, gin.H{
				"err": errCreate.Error(),
			})
			return
		}
		c.JSON(200, gin.H{
			"id": postReact.ID,
		})
		return
	}
	c.JSON(200, gin.H{})
}

func likeComment(c *gin.Context) {
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
	db := c.MustGet("db").(*gorm.DB)
	var commentReacts []CommentReact
	db.Table("comment_react").Where("reactor_uuid = ? AND comment_id=?", sessionVariables.XHasuraUserId, input.CommentId).Find(&commentReacts)
	if len(commentReacts) >= 1 {
		db.Table("comment_react").Delete(&commentReacts[0])
	} else {
		commentReact := CommentReact{PostID: input.PostId, ReactorUUID: sessionVariables.XHasuraUserId, CommentID: input.CommentId}
		if errCreate := db.Table("comment_react").Create(&commentReact).Error; errCreate != nil {
			c.JSON(400, gin.H{
				"err": errCreate.Error(),
			})
			return
		}
		c.JSON(200, gin.H{
			"id": commentReact.ID,
		})
		return
	}
	c.JSON(200, gin.H{})
}

type DataResponse struct {
	ID        int    `json:"id"`
	UUID      string `json:"uuid"`
	Name      string `json:"name"`
	AvatarUrl string `json:"avatar_url"`
}

func getAllUserInPost(c *gin.Context) {
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
	var data []DataResponse
	db := c.MustGet("db").(*gorm.DB)
	result := db.Table("users").Joins("join posts as p on p.creator_uuid = users.uuid").Where("p.id=?", input.PostId).Select("users.id,users.name,users.uuid,users.avatar_url").Scan(&data)
	if result.RowsAffected <= 0 {
		c.AbortWithStatus(400)
		return
	}
	var data2 []DataResponse
	db.Table("users").Joins("join comments as c on c.creator_uuid = users.uuid").Where("c.post_id=? AND users.uuid not in (?)", input.PostId, data[0].UUID).Group("users.id").Select("users.id,users.name,users.uuid,users.avatar_url").Scan(&data2)

	data = append(data, data2...)
	c.JSON(200, data)
	return
}
