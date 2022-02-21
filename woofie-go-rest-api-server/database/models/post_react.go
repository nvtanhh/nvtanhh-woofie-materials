package models

type PostReact struct {
	ID uint `json:"id"`

	PostID int `json:"post_id"`

	ReactorUUID string `json:"reactor_uuid"`
}
