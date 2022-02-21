package models

type Comment struct {
	ID int

	Content string	`json:"content"`

	PostID int `json:"post_id"`

	CreatorUUID string `json:"creator_uuid"`
}