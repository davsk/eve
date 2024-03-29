/* context.go

by David Skinner
on December 6, 2012
for Dasa Eve

*/

/* api package is a wrapper for all of the eve api calls as defined in 
http://wiki.eve-id.net/APIv2_Page_Index
useage example:
ctx, _ := api.NewContext(charId, corpId, testServer);
cs, _ := ctx.CharSheet.Open();  
industry = cs.SkillLevel(3300)
*/
package api

type Status int

const (
	StatusFound Status = iota
	StatusMissingCorpId
	StatusMissingCharId
	StatusMissingAll
)

var StatusString = map[Status]string{
	StatusFound:         "charId and corpId found.",
	StatusMissing:       "charId and corpId are missing",
	StatusMissingCorpId: "charId found, corpId missing.",
	StatusMissingCharId: "corpId found, charId missing",
}

// apiContext contains all of the values shared by all of the API calls
type apiContext struct {
	charId     int
	corpId     int
	testServer bool
	charKeyId  int
	charCode   string
	charCak    int
	corpKeyId  int
	corpCode   string
	corpCak    int
	status     Status
}

type apiCall struct {
	context *apiContext
	baseUrl string
	data    []byte
	status
}

func (a *apiCall) BaseUrl() string {
	if a.testServer {
		return "https://api.testeveonline.com"
	}
	return "https://api.eveonline.com"
}

type charCorpCall struct {
	apiCall
	cakMask int
	apiId   int
}



// NewContext inits values needed for APIs 
func (this apiContext) NewContext(charId int, corpId int, testServer bool) (ctx apiContext, err error) {
	this.charId = charId
	this.corpId = corpId
	this.testServer = testServer
	//  lookup charId
	//  lookup corpId
	return this, status
}

func (this apiContext) Status() string {
	return StatusString[this.status]
}
