package posts

import (
	"encoding/json"
	"go-woofie-api/database/models"
	"go-woofie-api/lib/common"
	"io/ioutil"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

type JSON = common.JSON

type Media = models.Media
type Post = models.Post
type User = models.User
type Pet = models.Pet
type PostPet = models.PostPet
type Location = models.Location
type RequestBody struct {
	Text string `json:"text"`
}

type EditedPost struct {
	OriginPostId        int       `json:"originPostId"`
	NewContent          string    `json:"newContent"`
	DeletedTaggedPetIds []int     `json:"deletedTaggedPetIds"`
	NewTaggedPetIds     []int     `json:"newTaggedPetIds"`
	DeletedMediaIds     []int     `json:"deletedMediaIds"`
	NewAddedMedias      []Media   `json:"newAddedMedias"`
	Location            *Location `json:"location"`
}

func edit(c *gin.Context) {

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

	var editedPost EditedPost

	errInput := json.Unmarshal(objMap["input"], &editedPost)
	if errInput != nil {
		c.AbortWithStatus(400)
		return
	}

	db := c.MustGet("db").(*gorm.DB)

	var post Post
	result := db.Table("posts").First(&post, editedPost.OriginPostId)
	if result.Error != nil {
		c.AbortWithStatus(404)
		return
	}

	if !isCanEdit(c, post) {
		c.JSON(http.StatusForbidden, gin.H{"status": "You don't have permission to edit this post."})
		return
	}

	tx := db.Begin()
	defer func() {
		if r := recover(); r != nil {
			tx.Rollback()
			c.AbortWithStatus(400)
			return
		}
	}()
	if err := tx.Error; err != nil {
		c.AbortWithStatus(500)
		return
	}

	for _, petId := range editedPost.DeletedTaggedPetIds {
		postPet := PostPet{PostId: editedPost.OriginPostId, PetId: petId}
		result := tx.Delete(&postPet)
		if result.Error != nil || result.RowsAffected < 1 {
			c.AbortWithStatus(404)
			tx.Rollback()
			return
		}
	}

	for _, petId := range editedPost.NewTaggedPetIds {
		postPet := PostPet{PostId: editedPost.OriginPostId, PetId: petId}
		result := tx.Create(&postPet)
		if result.Error != nil || result.RowsAffected < 1 {
			c.AbortWithStatus(404)
			tx.Rollback()
			return
		}
	}

	for _, mediaId := range editedPost.DeletedMediaIds {
		result := tx.Delete(&Media{}, mediaId)
		if result.Error != nil || result.RowsAffected < 1 {
			c.AbortWithStatus(404)
			tx.Rollback()
			return
		}
	}

	for _, media := range editedPost.NewAddedMedias {
		media.PostId = uint(editedPost.OriginPostId)
		result := tx.Create(&media)
		if result.Error != nil || result.RowsAffected < 1 {
			c.AbortWithStatus(404)
			tx.Rollback()
			return
		}
	}

	if editedPost.Location != nil {
		if post.LocationId != nil {
			var location Location
			result := tx.First(&location, *post.LocationId)
			if result.Error != nil {
				c.AbortWithStatus(404)
				tx.Rollback()
				return
			}
			location.Lat = editedPost.Location.Lat
			location.Long = editedPost.Location.Long
			location.Name = editedPost.Location.Name
			tx.Save(&location)
		} else {
			result := tx.Create(&editedPost.Location)
			if result.Error != nil || result.RowsAffected < 1 {
				c.AbortWithStatus(404)
				tx.Rollback()
				return
			}
			post.LocationId = &editedPost.Location.Id
		}

	}
	post.Content = editedPost.NewContent
	tx.Save(&post)
	tx.Commit()
	c.JSON(http.StatusOK, gin.H{"status": "Post updated"})
}

func isCanEdit(c *gin.Context, post Post) bool {
	userUuid := c.GetString("user_uuid")
	if userUuid == "" {
		return false
	}

	return post.CreatorUuid == userUuid

}
