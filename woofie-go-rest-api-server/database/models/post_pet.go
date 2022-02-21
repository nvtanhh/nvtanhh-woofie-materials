package models

type PostPet struct {
	PostId int
	PetId  int
}

func (PostPet) TableName() string {
	return "post_pet"
}
