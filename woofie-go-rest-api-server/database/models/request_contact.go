package models

import "time"

type RequestContact struct {
	ID int `json:"id"`
	Content string `json:"content"`
	Status int `json:"status"`
	FromUserUUID string `json:"from_user_uuid"`
	ToUserUUID string `json:"to_user_uuid"`
	UpdateAt time.Time `json:"update_at"`
}
