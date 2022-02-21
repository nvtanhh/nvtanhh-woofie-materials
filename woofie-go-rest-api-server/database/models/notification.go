package models

type Notification struct {
	ID uint `json:"id"`
	ActorUUID string `json:"actor_uuid"`
	PostID    int    `json:"post_id"`
	PetID     int    `json:"pet_id"`
	OwnerID   int    `json:"owner_id"`
	IsRead    bool   `json:"is_read"`
	Type      int    `json:"type"`
	OwnerUUID string `json:"owner_uuid"`
}
