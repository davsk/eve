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

// apiContext contains all of the values shared by all of the API calls
type apiContext struct {
	charId int
	corpId int
	testServer bool
	charKeyId int
	charCode string
	charCak int
	corpKeyId int
	corpCode string
	corpCak int 
	status int
}

type apiCall struct {
	context *apiContext
	baseUrl string
	data []byte
	status
}

func (a *apiCall) BaseUrl() string {
	if a.testServer ? "https://api.testeveonline.com" : "https://api.eveonline.com" 	
}

type charCorpCall struct {
	apiCall
	cakMask int
	apiId int
}

type charCall struct {
	charCorpCall
}

func (c *charCall) setBaseUrl(cmd string) {
	c.baseUrl =  fmt.sprintf("%s/char/%s.xml.aspx?keyID=%s&vCode=%s&characterID=%s", 
		c.BaseUrl(),
		cmd, 
		c.context.charKeyId,
		c.context.charCode,
		c.context.charId)	
}

func (c *charCall) loadData() {
	// lookup db
	// if !expired
	//   load from db
	// if expired
	//   load from api
	// if api failed
	//   load from db
	// return status	
}

type CharSheet struct {
	charCall
}

func (c *CharSheet) Open() {
	c.setBaseUrl("CharacterString")
	c.apiId = 4
	c.cakMask = 8
	c.loadData()
	// optional move data to struct
	return c
}

// NewContext inits values needed for APIs 
func (this apiContext) NewContext(charId int, corpId int, testServer bool) ctx apiContext, err Err {
	this.charId = charId
	this.corpId = corpId
	this.testServer = testServer
	//  lookup charId
	//  lookup corpId
	return this, status
}


func (this apiContext) Status() string {
	const (
		statusString []string = [
			"charId and corpId found.",
			"charId found, corpId missing.",
			"corpId found, charId missing",
			"charId and corpId are missing"]
	)	
	return statusString[this.status]
}