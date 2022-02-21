package models

import (
	"go-woofie-api/lib/common"
	"time"
)

// User data model
type User struct {
	ID          uint      `gorm:"primary_key" json:"id"`
	UUID        string    `json:"uuid"`
	Name        string    `json:"name"`
	PhoneNumber string    `json:"phone_number"`
	AvatarUrl   string    `json:"avatar_url"`
	Email       string    `json:"email"`
	LocationId  int       `json:"location_id"`
	BIO         string    `json:"bio"`
	DOB         time.Time `json:"dob"`
}

// Serialize serializes user data
func (u *User) Serialize() common.JSON {
	return common.JSON{
		"id":           u.ID,
		"uuid":         u.UUID,
		"name":         u.Name,
		"phone_number": u.PhoneNumber,
		"avatar_url":   u.AvatarUrl,
		"email":        u.Email,
		"location_id":  u.LocationId,
		"bio":          u.BIO,
	}
}

//
//func (u *User) Read(m common.JSON) {
//	u.ID = uint(m["id"].(float64))
//	u.Username = m["username"].(string)
//	u.DisplayName = m["display_name"].(string)
//}
