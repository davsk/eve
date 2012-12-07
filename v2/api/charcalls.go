/* charcalls.go

by David Skinner
on December 6, 2012
for Dasa Eve

*/

package api

// charCall is parent for all char api calls.
type charCall struct {
	charCorpCall
}

//  setBaseUrl creates the url for all char api calls.
func (c *charCall) setBaseUrl(cmd string, append string) {
	c.baseUrl = fmt.sprintf("%s/char/%s.xml.aspx?keyID=%s&vCode=%s&characterID=%s%s",
		c.BaseUrl(),
		cmd,
		c.context.charKeyId,
		c.context.charCode,
		c.context.charId,
		append)
}

// loadData checks db cache and gets xml for all char api calls. 
func (c *charCall) loadData(selectId) {
	// lookup db
	// if !expired
	//   load from db
	// if expired
	//   load from api
	// if api failed
	//   load from db
	// return status	
}


// CharAccountBalance returns the ISK balance of a character.
type CharAccountBalance struct {
	charCall
}

func (c *CharAccountBalance) Open() {
	c.setBaseUrl("AccountBalance","")
	c.apiId = 1
	c.cakMask = 1
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharAssetList returns a list of assets owned by a character.
type CharAssetList struct {
	charCall
}

func (c *CharAssetlist) Open() {
	c.setBaseUrl("AssetList","")
	c.apiId = 2
	c.cakMask = 2
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharCalendarEventAttendees returns a list of all invited attendees for a given event.
type CharCalendarEventAttendees struct {
	charCall
}

func (c *CharCalendarEventAttendees) Open(eventId int) {
	c.setBaseUrl("CalendarEventAttendees", fmt.Sprintf("&eventID=%s",eventId))
	c.apiId = 3
	c.cakMask = 4
	// TODO get list of eventIds from CharUpcomingCalendarEvents
	// TODO verify eventId 
	c.loadData(eventId)
	// TODO optional move data to struct
	return c
}

// CharSheet returns attributes relating to a specific character.
type CharSheet struct {
	charCall
}

func (c *CharSheet) Open() {
	c.setBaseUrl("CharacterSheet","")
	c.apiId = 4
	c.cakMask = 8
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharContactList returns the character's contact and watch lists, 
// incl. agents and respective standings set by the character. 
// Also includes that character's corporation and/or alliance contacts.
type CharContactList struct {
	charCall
}

func (c *CharContactLlist) Open() {
	c.setBaseUrl("ContactList","")
	c.apiId = 5
	c.cakMask = 16 
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharContactNotifications lists the notifications received about having been added to someone's contact list.
type CharContactNotifications struct {
	charCall
}

func (c *CharContactNotifications) Open() {
	c.setBaseUrl("ContactNotifications","")
	c.apiId = 6
	c.cakMask = 32
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharContracts Lists the personal contracts for a character.
type CharContracts struct {
	charCall
}

func (c *CharContracts) Open() {
	c.setBaseUrl("Contracts","")
	c.apiId = 7 
	c.cakMask = 67108864 
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharContractItems Lists items that a specified contract contains.
type CharContractItems struct {
	charCall
}

func (c *CharContractItems) Open(contractId int) {
	c.setBaseUrl("ContractItems", fmt.Sprintf("&contractID=%s",contractId))
	c.apiId = 8 
	c.cakMask = 67108864
	c.loadData(contractId)
	// optional move data to struct
	return c
}

// CharContractBids Lists the latest bids that have been made to any recent auctions.
type CharContractBids struct {
	charCall
}

func (c *CharContractBids) Open() {
	c.setBaseUrl("ContractBids","")
	c.apiId = 9
	c.cakMask = 67108864
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharFacWarStats If the character is enlisted in Factional Warfare, 
// this will return the faction the character is enlisted in, 
// the current rank and the highest rank the character ever had attained, 
// and how many kills and victory points the character obtained yesterday, 
// in the last week, and total. Otherwise returns an error code.
type CharFacWarStats struct {
	charCall
}

func (c *CharFacWarStats) Open() {
	c.setBaseUrl("FacWarStats","")
	c.apiId = 10
	c.cakMask = 64
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharIndustryJobs 
type CharIndustryJobs struct {
	charCall
}

func (c *CharIndustryJobs) Open() {
	c.setBaseUrl("IndustryJobs","")
	c.apiId = 11
	c.cakMask = 128
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharKillLog Returns a list of kills where this character received the final blow 
// and losses of this character. For characters, returns the most recent 25, 
// for corporations, the most recent 100. 
type CharKillLog struct {
	charCall
}

// You can scroll back with the beforeKillID parameter.
func (c *CharKillLog) Open(beforeKillId int) {
	if beforeKillId > 0 {
		c.setBaseUrl("KillLog",fmt.Sprintf("&beforeKillID=%s", beforeKillId))
	} else {
		c.setBaseUrl("KillLog","")
	}
	c.apiId = 12
	c.cakMask = 256
	c.loadData(beforeKillId)
	// optional move data to struct
	return c
}

// CharLocations Call will return the items name 
// (or its type name if no user defined name exists) 
// as well as their x,y,z coordinates. 
// Coordinates should all be 0 for valid locations located inside of stations.
type CharLocations struct {
	charCall
}

func (c *CharLocations) Open(itemId int) {
	c.setBaseUrl("Locations",fmt.Sprintf("&IDs=%s", itemId))
	c.apiId = 13
	c.cakMask = 134217725
	c.loadData(itemId)
	// optional move data to struct
	return c
}

// CharMailBodies Returns the bodies of headers that have already been fetched 
// with the MailMessages call. It will also return a list of missing IDs that 
// could not be accessed. Bodies cannot be accessed if you have not called for 
// their headers recently.
type CharMailBodies struct {
	charCall
}

func (c *CharMailBodies) Open(messageId int) { // TODO use list of messageIds
	c.setBaseUrl("MailBodies",fmt.Sprintf("&ids=%s",messageId))
	c.apiId = 14
	c.cakMask = 512
	c.loadData(messageId)
	// optional move data to struct
	return c
}

// CharMailingLists Returns an XML document listing all mailing lists 
// the character is currently a member of.
type CharMailingLists struct {
	charCall
}

func (c *CharMailingLists) Open() {
	c.setBaseUrl("MailingLists","")
	c.apiId = 15
	c.cakMask = 1024 
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharMailMessages Returns the message headers for mail.
// The first request returns the latest 50 mails/200 notifications 
// sent or received by the character within the last 10 days. Older items are skipped.
// Subsequent requests return only the new items recieved since the last request.
// You can request new items every 30 minutes.
// If you want to re-set the timer and get the first-request bulk again, you'll have to wait 6 hours.
type CharMailMessages struct {
	charCall
}

func (c *CharMailMessages) Open() {
	c.setBaseUrl("MailMessages","")
	c.apiId = 16
	c.cakMask = 2048
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharMarketOrders Returns a list of market orders for your character.
type CharMarketOrders struct {
	charCall
}

func (c *CharMarketOrders) Open() { // TODO Optional - market order ID to fetch an order that is no longer open.
	c.setBaseUrl("MarketOrders","")
	c.apiId = 17
	c.cakMask = 4096
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharMedals Returns a list of medals the character has.
type CharMedals struct {
	charCall
}

func (c *CharMedals) Open() {
	c.setBaseUrl("Medals","")
	c.apiId = 18
	c.cakMask = 8192
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharNotifications Returns the message headers for notifications.
// The first request returns the latest 200 notifications received 
// by the character within the last week.
// Subsequent requests return only the new items received since the last request.
// You can request new items every 30 minutes.
// If you want to reset the timer and get the first-request bulk again, you'll have to wait 6 hours.
type CharNotifications struct {
	charCall
}

func (c *CharNotifications) Open() {
	c.setBaseUrl("Notifications","")
	c.apiId = 19
	c.cakMask = 16384
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharNotificationTexts Returns the message bodies for notifications.
// Headers need to be requested via /char/Notifications.xml.aspx first.
type CharNotificationTexts struct {
	charCall
}

func (c *CharNotificationTexts) Open() {
	// TODO comma separated list of notificationIDs obtained via the /char/Notifications.xml.aspx API call.
	c.setBaseUrl("NotificationTexts","")
	c.apiId = 20
	c.cakMask = 32768
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharResearch Returns information about agents character is doing research with.
// Notice that remainderPoints will be a negative number if you've bought datacores from agent.
// Formula for finding current RP you have is: 
// currentPoints = remainderPoints + pointsPerDay * <Difference between now and startdate>
type CharResearch struct {
	charCall
}

func (c *CharResearch) Open() {
	c.setBaseUrl("Research","")
	c.apiId = 21
	c.cakMask = 65536
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharSkillInTraining 
type CharSkillInTraining struct {
	charCall
}

func (c *CharSkillInTraining) Open() {
	c.setBaseUrl("SkillInTraining","")
	c.apiId = 22
	c.cakMask = 131072
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharSkillQueue
type CharSkillQueue struct {
	charCall
}

func (c *CharSkillQueue) Open() {
	c.setBaseUrl("SkillQueue","")
	c.apiId = 23 
	c.cakMask = 262144
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharStandings
type CharStandings struct {
	charCall
}

func (c *CharStandings) Open() {
	c.setBaseUrl("Standings","")
	c.apiId = 24
	c.cakMask = 524288
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharUpcomingCalendarEvents Returns a list of all upcomming calendar events for a given character.
type CharUpcomingCalendarEvents struct {
	charCall
}

func (c *CharUpcomingCalendarEvents) Open() {
	c.setBaseUrl("UpcomingCalendarEvents","")
	c.apiId = 25
	c.cakMask = 1048576
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharWalletJournal 
type CharWalletJournal struct {
	charCall
}

func (c *CharWalletJournal) Open() { // TODO http://wiki.eve-id.net/APIv2_Char_JournalEntries_XML
	c.setBaseUrl("WalletJournal","")
	c.apiId = 26
	c.cakMask = 2097152
	c.loadData(0)
	// optional move data to struct
	return c
}

// CharWalletTransactions
type CharWalletTransactions struct {
	charCall
}

func (c *CharWalletTransactions) Open() { // TODO http://wiki.eve-id.net/APIv2_Char_MarketTransactions_XML
	c.setBaseUrl("WalletTransactions","")
	c.apiId = 27
	c.cakMask = 4194304
	c.loadData(0)
	// optional move data to struct
	return c
}

