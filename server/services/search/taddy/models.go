// Models for Taddy Search Response 
package taddy

type TaddySearchQueryResponse struct {
	Data   TaddySearchResponse `json:"data"`
	Errors []TaddyErrors       `json:"errors"`
}
type TaddyErrors struct {
	Message string `json:"message"`
}
type TaddySearchResponse struct {
	Search TaddySearchResults `json:"search"`
}
type TaddySearchResults struct {
	SearchId string         `json:"searchId"`
	Podcasts []TaddyPodcast `json:"podcastSeries"`
}
type TaddyPodcast struct {
	Uuid        string `json:"uuid"`
	Name        string `json:"name"`
	Description string `json:"description"`
	ImageUrl    string `json:"imageUrl"`
	RssUrl      string `json:"rssUrl"`
}
