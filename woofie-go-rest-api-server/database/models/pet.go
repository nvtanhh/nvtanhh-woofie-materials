package models

type Pet struct {
	//gorm.Model
	ID uint `gorm:"primary_key"`

	Name string

	PetTypeId int

	Gender     int

	PetBreedId int

	BIO string

	FatherId int

	Avatar int

	CurrentOwnerUUID string

}
