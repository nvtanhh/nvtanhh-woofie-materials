package models

type CommentTagUser struct {
	ID uint `json:"id"`
	CommentID int `json:"comment_id"`
	UserID int `json:"user_id"`
	PostID int `json:"post_id"`
}
