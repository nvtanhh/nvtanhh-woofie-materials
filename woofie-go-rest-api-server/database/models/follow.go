package models

type Follow struct {
	ID uint `json:"id"`

	UserUuid string `json:"user_uuid"`

	PetId int `json:"pet_id"`
}
