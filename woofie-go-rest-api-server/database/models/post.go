package models

// Post data model
type Post struct {
	Id          uint `gorm:"primary_key" json:"id"`
	Content     string `json:"content"`
	CreatorUuid string `json:"creator_uuid"`
	LocationId  *uint `json:"location_id"`
	Type        int `json:"type"`
}

