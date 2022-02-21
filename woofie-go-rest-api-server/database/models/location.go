package models

type Location struct {
	Id   uint    `gorm:"primary_key"`
	Lat  float32 `json:"lat"`
	Long float32 `json:"long"`
	Name string  `json:"name"`
}
