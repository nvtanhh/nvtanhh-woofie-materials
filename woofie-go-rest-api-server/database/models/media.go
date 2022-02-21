package models

type Media struct {
	Id     uint   `gorm:"primary_key" json:"id"`
	Url    string `json:"url"`
	Type   int    `json:"type"`
	PostId uint   `json:"post_id"`
}

func (Media) TableName() string {
	return "medias"
}
