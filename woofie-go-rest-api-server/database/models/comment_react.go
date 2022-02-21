package models

type CommentReact struct {
	ID uint `json:"id"`
	CommentID int `json:"comment_id"`
	ReactorUUID string `json:"reactor_uuid"`
	PostID int `json:"post_id"`
}