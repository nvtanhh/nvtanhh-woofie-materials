package notification

import (
	"bytes"
	"encoding/json"
	"fmt"
	"go-woofie-api/database/models"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"
)

func sendNotifyFollow(playerId []string, actor User, pet Pet) bool {
	conntent := map[string]string{
		"vi": actor.Name + " đã theo đõi " + pet.Name,
		"en": actor.Name + " followed " + pet.Name,
	}
	headings := map[string]string{
		"vi": "Theo dõi",
		"en": "Follow",
	}
	return sendNotificationForPerson(playerId, headings, conntent, nil)
}
func sendNotifyComment(playerId []string, actor User, post models.Post) bool {
	content := map[string]string{
		"vi": actor.Name + " đã bình luận về bài viết của bạn",
		"en": actor.Name + " commented on your post",
	}
	headings := map[string]string{
		"vi": "Bình luận",
		"en": "Comment",
	}
	return sendNotificationForPerson(playerId, headings, content, post)
}
func sendNotifyCommentTagUser(playerId []string, actor User, post models.Post) bool {
	content := map[string]string{
		"vi": actor.Name + " đã nhắc đến bạn trong một bài viết",
		"en": actor.Name + " mention you in a post",
	}
	headings := map[string]string{
		"vi": "Tương tác",
		"en": "Mention",
	}
	return sendNotificationForPerson(playerId, headings, content, post)
}
func sendNotifyLike(playerId []string, actor User, post models.Post) bool {
	content := map[string]string{
		"vi": actor.Name + " đã thích bài viết của bạn",
		"en": actor.Name + " liked your post",
	}
	headings := map[string]string{
		"vi": "Tương tác",
		"en": "React",
	}
	return sendNotificationForPerson(playerId, headings, content, post)
}
func sendNotifyLikeComment(playerId []string, actor User, post models.Post) bool {
	content := map[string]string{
		"vi": actor.Name + " đã thích bình luận của bạn",
		"en": actor.Name + " liked your comment",
	}
	headings := map[string]string{
		"en": "React",
		"vi": "Tương tác",
	}
	return sendNotificationForPerson(playerId, headings, content, post)
}

func sendNotifyAdopt(playerId []string, actor User, pet Pet, post models.Post) bool {
	content := map[string]string{
		"vi": actor.Name + " muốn liên hệ với bạn để nhận nuôi " + pet.Name,
		"en": actor.Name + " wants to contact you to adopt " + pet.Name,
	}
	headings := map[string]string{
		"vi": "Nhận nuôi thú cưng",
		"en": "Adopt",
	}
	return sendNotificationForPerson(playerId, headings, content, nil)
}
func sendNotifyMatting(playerId []string, actor User, pet Pet, post models.Post) bool {
	content := map[string]string{
		"vi": actor.Name + " muốn liên hệ với bạn để phối giống cho" + pet.Name,
		"en": actor.Name + " wants to contact you to breed " + pet.Name,
	}
	headings := map[string]string{
		"vi": "Tìm bạn tình",
		"en": "Matting",
	}
	return sendNotificationForPerson(playerId, headings, content, nil)
}
func sendNewRequestMessage(playerId []string) bool {
	content := map[string]string{
		"vi": "Bạn có 1 tin nhắn chờ mới",
		"en": "You have 1 new message waiting",
	}
	headings := map[string]string{
		"vi": "Chat",
		"en": "Chat",
	}
	return sendNotificationForPerson(playerId, headings, content, nil)
}
func sendNotifyLose(pet Pet, location Location, post interface{}, radius int) bool {
	contents := map[string]string{
		"vi": strings.ToUpper(pet.Name) + " thất lạc ở gần khu vực của bạn 🆘",
		"en": strings.ToUpper(pet.Name) + " got lost near your area 🆘",
	}
	headings := map[string]string{
		"vi": "🆘 Thú cưng thất lạc 🆘",
		"en": "🆘 Lost 🆘",
	}
	if post == nil {
		post = map[string]string{}
	} else {
		post = map[string]interface{}{
			"post_id": post.(models.Post).Id,
			"post_type": post.(models.Post).Type,
		}
	}
	appID := os.Getenv("APP_ID")
	body := map[string]interface{}{
		"app_id":   appID,
		"headings": headings,
		"contents": contents,
		"filters":  [1]interface{}{map[string]interface{}{"field": "location", "radius": fmt.Sprintf("%d", radius), "lat": fmt.Sprintf("%g", location.Lat), "long": fmt.Sprintf("%g", location.Long)}},
		"data":     post,
	}
	return sendRequestToOneSignal(body)
}

//https://blog.logrocket.com/making-http-requests-in-go/
func sendNotificationForPerson(playerId []string, headings map[string]string, contents map[string]string, post interface{}) bool {
	if len(playerId) == 0 {
		return false
	}
	if post == nil {
		post = map[string]string{}
	} else {
		post = map[string]interface{}{
			"post_id": post.(models.Post).Id,
		}
	}
	appID := os.Getenv("APP_ID")
	body := map[string]interface{}{
		"app_id":                    appID,
		"include_external_user_ids": playerId,
		"headings":                  headings,
		"contents":                  contents,
		"data":                      post,
	}
	return sendRequestToOneSignal(body)
}
func sendRequestToOneSignal(requestBody map[string]interface{}) bool {
	url := os.Getenv("ONESIGNAL_URL")
	restApiKey := os.Getenv("REST_API_KEY")
	postBody, _ := json.Marshal(requestBody)

	responseBody := bytes.NewBuffer(postBody)
	request, error := http.NewRequest("POST", url, responseBody)
	request.Header.Set("Content-Type", "application/json; charset=UTF-8")
	request.Header.Set("Authorization", "Basic "+restApiKey)
	client := &http.Client{}
	response, error := client.Do(request)
	if error != nil {
		log.Printf(error.Error())
	}
	defer response.Body.Close()
	//Read the response body
	body, error := ioutil.ReadAll(response.Body)
	if error != nil {
		log.Printf(error.Error())
	}
	sb := string(body)
	log.Printf(sb)
	return true
}
