/*  moresetuppg */

CREATE TABLE dbo.agtAgents(
	agentID int NOT NULL,
	divisionID smallint NULL,
	corporationID int NULL,
	locationID int NULL,
	level smallint NULL,
	quality smallint NULL,
	agentTypeID int NULL,
	isLocator bit NULL,
 CONSTRAINT agtAgents_PK PRIMARY KEY (agentID ASC)
);


/****** Object:  Table dbo.agtResearchAgents    Script Date: 11/19/2012 16:10:04 ******/

CREATE TABLE dbo.agtResearchAgents(
	agentID int NOT NULL,
	typeID int NOT NULL,
 CONSTRAINT agtResearchAgents_PK PRIMARY KEY  
(
	agentID ASC,
	typeID ASC
)
);


/****** Object:  Table dbo.crpNPCCorporationDivisions    Script Date: 11/19/2012 16:10:51 ******/

CREATE TABLE dbo.crpNPCCorporationDivisions(
	corporationID int NOT NULL,
	divisionID smallint NOT NULL,
	size smallint NULL,
 CONSTRAINT crpNPCCorporationDivisions_PK PRIMARY KEY  
(
	corporationID ASC,
	divisionID ASC
)
) ;


/****** Object:  Table dbo.crpNPCCorporations    Script Date: 11/19/2012 16:11:27 ******/

CREATE TABLE dbo.crpNPCCorporations(
	corporationID int NOT NULL,
	size char(1) NULL,
	extent char(1) NULL,
	solarSystemID int NULL,
	investorID1 int NULL,
	investorShares1 smallint NULL,
	investorID2 int NULL,
	investorShares2 smallint NULL,
	investorID3 int NULL,
	investorShares3 smallint NULL,
	investorID4 int NULL,
	investorShares4 smallint NULL,
	friendID int NULL,
	enemyID int NULL,
	publicShares bigint NULL,
	initialPrice int NULL,
	minSecurity real NULL,
	scattered bit NULL,
	fringe smallint NULL,
	corridor smallint NULL,
	hub smallint NULL,
	border smallint NULL,
	factionID int NULL,
	sizeFactor real NULL,
	stationCount smallint NULL,
	stationSystemCount smallint NULL,
	description nvarchar(4000) NULL,
	iconID int NULL,
 CONSTRAINT crpNPCCorporations_PK PRIMARY KEY  
(
	corporationID ASC
)
) ;


/****** Object:  Table dbo.translationTables    Script Date: 11/19/2012 16:12:56 ******/

CREATE TABLE dbo.translationTables(
	sourceTable text NOT NULL,
	destinationTable text NULL,
	translatedKey text NOT NULL,
	tcGroupID int NULL,
	tcID int NULL,
 CONSTRAINT translationTables_PK PRIMARY KEY  
(
	sourceTable ASC,
	translatedKey ASC
)
) ;


/****** Object:  Table dbo.eveIcons    Script Date: 11/19/2012 16:13:35 ******/

CREATE TABLE dbo.eveIcons(
	iconID int NOT NULL,
	iconFile text NOT NULL,
	description text NOT NULL,
 CONSTRAINT eveIcons_PK PRIMARY KEY  
(
	iconID ASC
)
) ;


ALTER TABLE dbo.eveIcons ADD  DEFAULT ('') FOR iconFile


ALTER TABLE dbo.eveIcons ADD  DEFAULT ('') FOR description


/****** Object:  Table dbo.invItems    Script Date: 11/19/2012 16:14:02 ******/

CREATE TABLE dbo.invItems(
	itemID bigint NOT NULL,
	typeID int NOT NULL,
	ownerID int NOT NULL,
	locationID bigint NOT NULL,
	flagID smallint NOT NULL,
	quantity int NOT NULL,
 CONSTRAINT invItems_PK PRIMARY KEY  
(
	itemID ASC
)
) ;


/****** Object:  Table dbo.invUniqueNames    Script Date: 11/19/2012 16:14:41 ******/

CREATE TABLE dbo.invUniqueNames(
	itemID int NOT NULL,
	itemName text NOT NULL,
	groupID int NULL,
 CONSTRAINT invUniqueNames_PK PRIMARY KEY  
(
	itemID ASC
)
) ;


/****** Object:  Table dbo.invNames    Script Date: 11/19/2012 16:15:05 ******/

CREATE TABLE dbo.invNames(
	itemID bigint NOT NULL,
	itemName text NOT NULL,
 CONSTRAINT invNames_PK PRIMARY KEY  
(
	itemID ASC
)
) ;


/****** Object:  Table dbo.invPositions    Script Date: 11/19/2012 16:15:41 ******/

CREATE TABLE dbo.invPositions(
	itemID bigint NOT NULL,
	x real NOT NULL,
	y real NOT NULL,
	z real NOT NULL,
	yaw real NULL,
	pitch real NULL,
	roll real NULL,
 CONSTRAINT invPositions_PK PRIMARY KEY  
(
	itemID ASC
)
) ;

ALTER TABLE dbo.invPositions ADD  DEFAULT ((0.0)) FOR x

ALTER TABLE dbo.invPositions ADD  DEFAULT ((0.0)) FOR y

ALTER TABLE dbo.invPositions ADD  DEFAULT ((0.0)) FOR z


/****** Object:  Table dbo.invCategories    Script Date: 11/19/2012 16:16:52 ******/

CREATE TABLE dbo.invCategories(
	categoryID int NOT NULL,
	categoryName text NULL,
	description text NULL,
	iconID int NULL,
	published bit NULL,
 CONSTRAINT invCategories_PK PRIMARY KEY  
(
	categoryID ASC
)
) ;


/****** Object:  Table dbo.invContrabandTypes    Script Date: 11/19/2012 16:17:14 ******/

CREATE TABLE dbo.invContrabandTypes(
	factionID int NOT NULL,
	typeID int NOT NULL,
	standingLoss real NULL,
	confiscateMinSec real NULL,
	fineByValue real NULL,
	attackMinSec real NULL,
 CONSTRAINT invContrabandTypes_PK PRIMARY KEY  
(
	factionID ASC,
	typeID ASC
)
) ;


/****** Object:  Table dbo.invGroups    Script Date: 11/19/2012 16:17:51 ******/


CREATE TABLE dbo.invGroups(
	groupID int NOT NULL,
	categoryID int NULL,
	groupName text NULL,
	description text NULL,
	iconID int NULL,
	useBasePrice bit NULL,
	allowManufacture bit NULL,
	allowRecycler bit NULL,
	anchored bit NULL,
	anchorable bit NULL,
	fittableNonSingleton bit NULL,
	published bit NULL,
 CONSTRAINT invGroups_PK PRIMARY KEY  
(
	groupID ASC
)
) ;


/****** Object:  Table dbo.invTypes    Script Date: 11/19/2012 16:18:14 ******/

CREATE TABLE dbo.invTypes(
	typeID int NOT NULL,
	groupID int NULL,
	typeName text NULL,
	description text NULL,
	mass real NULL,
	volume real NULL,
	capacity real NULL,
	portionSize int NULL,
	raceID smallint NULL,
	basePrice money NULL,
	published bit NULL,
	marketGroupID int NULL,
	chanceOfDuplicating real NULL,
	iconID int NULL,
 CONSTRAINT invTypes_PK PRIMARY KEY  
(
	typeID ASC
)
) ;


/****** Object:  Table dbo.mapConstellationJumps    Script Date: 11/19/2012 16:18:49 ******/

CREATE TABLE dbo.mapConstellationJumps(
	fromRegionID int NULL,
	fromConstellationID int NOT NULL,
	toConstellationID int NOT NULL,
	toRegionID int NULL,
 CONSTRAINT mapConstellationJumps_PK PRIMARY KEY  
(
	fromConstellationID ASC,
	toConstellationID ASC
)
) ;


/****** Object:  Table dbo.mapConstellations    Script Date: 11/19/2012 16:19:14 ******/

CREATE TABLE dbo.mapConstellations(
	regionID int NULL,
	constellationID int NOT NULL,
	constellationName text NULL,
	x real NULL,
	y real NULL,
	z real NULL,
	xMin real NULL,
	xMax real NULL,
	yMin real NULL,
	yMax real NULL,
	zMin real NULL,
	zMax real NULL,
	factionID int NULL,
	radius real NULL,
 CONSTRAINT mapConstellations_PK PRIMARY KEY  
(
	constellationID ASC
)
) ;


/****** Object:  Table dbo.mapLandmarks    Script Date: 11/19/2012 16:28:12 ******/

CREATE TABLE dbo.mapLandmarks(
	landmarkID smallint NOT NULL,
	landmarkName varchar(100) NULL,
	description varchar(7000) NULL,
	locationID int NULL,
	x real NULL,
	y real NULL,
	z real NULL,
	radius real NULL,
	iconID int NULL,
	importance smallint NULL,
 CONSTRAINT mapLandmarks_PK PRIMARY KEY  
(
	landmarkID ASC
)
) ;


/****** Object:  Table dbo.mapRegions    Script Date: 11/19/2012 16:30:18 ******/

CREATE TABLE dbo.mapRegions(
	regionID int NOT NULL,
	regionName text NULL,
	x real NULL,
	y real NULL,
	z real NULL,
	xMin real NULL,
	xMax real NULL,
	yMin real NULL,
	yMax real NULL,
	zMin real NULL,
	zMax real NULL,
	factionID int NULL,
	radius real NULL,
 CONSTRAINT mapRegions_PK PRIMARY KEY  
(
	regionID ASC
)
) ;


/****** Object:  Table dbo.mapSolarSystemJumps    Script Date: 11/19/2012 16:34:02 ******/

CREATE TABLE dbo.mapSolarSystemJumps(
	fromRegionID int NULL,
	fromConstellationID int NULL,
	fromSolarSystemID int NOT NULL,
	toSolarSystemID int NOT NULL,
	toConstellationID int NULL,
	toRegionID int NULL,
 CONSTRAINT mapSolarSystemJumps_PK PRIMARY KEY  
(
	fromSolarSystemID ASC,
	toSolarSystemID ASC
)
) ;


/****** Object:  Table dbo.mapSolarSystems    Script Date: 11/19/2012 16:35:26 ******/

CREATE TABLE dbo.mapSolarSystems(
	regionID int NULL,
	constellationID int NULL,
	solarSystemID int NOT NULL,
	solarSystemName text NULL,
	x real NULL,
	y real NULL,
	z real NULL,
	xMin real NULL,
	xMax real NULL,
	yMin real NULL,
	yMax real NULL,
	zMin real NULL,
	zMax real NULL,
	luminosity real NULL,
	border bit NULL,
	fringe bit NULL,
	corridor bit NULL,
	hub bit NULL,
	international bit NULL,
	regional bit NULL,
	constellation bit NULL,
	security real NULL,
	factionID int NULL,
	radius real NULL,
	sunTypeID int NULL,
	securityClass varchar(2) NULL,
 CONSTRAINT mapSolarSystems_PK PRIMARY KEY  
(
	solarSystemID ASC
)
) ;


/****** Object:  Table dbo.mapUniverse    Script Date: 11/19/2012 16:36:08 ******/

CREATE TABLE dbo.mapUniverse(
	universeID int NOT NULL,
	universeName varchar(100) NULL,
	x real NULL,
	y real NULL,
	z real NULL,
	xMin real NULL,
	xMax real NULL,
	yMin real NULL,
	yMax real NULL,
	zMin real NULL,
	zMax real NULL,
	radius real NULL,
 CONSTRAINT mapUniverse_PK PRIMARY KEY  
(
	universeID ASC
)
) ;


/****** Object:  Table dbo.ramAssemblyLines    Script Date: 11/19/2012 16:36:55 ******/

CREATE TABLE dbo.ramAssemblyLines(
	assemblyLineID int NOT NULL,
	assemblyLineTypeID smallint NULL,
	containerID int NULL,
	nextFreeTime smalldatetime NULL,
	UIGroupingID smallint NULL,
	costInstall real NULL,
	costPerHour real NULL,
	restrictionMask smallint NULL,
	discountPerGoodStandingPoint real NULL,
	surchargePerBadStandingPoint real NULL,
	minimumStanding real NULL,
	minimumCharSecurity real NULL,
	minimumCorpSecurity real NULL,
	maximumCharSecurity real NULL,
	maximumCorpSecurity real NULL,
	ownerID int NULL,
	activityID smallint NULL,
 CONSTRAINT ramAssemblyLines_PK PRIMARY KEY  
(
	assemblyLineID ASC
)
) ;


/****** Object:  Table dbo.ramAssemblyLineStations    Script Date: 11/19/2012 16:37:19 ******/

CREATE TABLE dbo.ramAssemblyLineStations(
	stationID int NOT NULL,
	assemblyLineTypeID smallint NOT NULL,
	quantity smallint NULL,
	stationTypeID int NULL,
	ownerID int NULL,
	solarSystemID int NULL,
	regionID int NULL,
 CONSTRAINT ramAssemblyLineStations_PK PRIMARY KEY  
(
	stationID ASC,
	assemblyLineTypeID ASC
)
) ;


/****** Object:  Table dbo.staStations    Script Date: 11/19/2012 16:38:04 ******/

CREATE TABLE dbo.staStations(
	stationID int NOT NULL,
	security smallint NULL,
	dockingCostPerVolume real NULL,
	maxShipVolumeDockable real NULL,
	officeRentalCost int NULL,
	operationID smallint NULL,
	stationTypeID int NULL,
	corporationID int NULL,
	solarSystemID int NULL,
	constellationID int NULL,
	regionID int NULL,
	stationName text NULL,
	x real NULL,
	y real NULL,
	z real NULL,
	reprocessingEfficiency real NULL,
	reprocessingStationsTake real NULL,
	reprocessingHangarFlag smallint NULL,
 CONSTRAINT staStations_PK PRIMARY KEY  
(
	stationID ASC
)
) ;


/****** Object:  Table dbo.crtCertificates    Script Date: 11/19/2012 16:38:42 ******/

CREATE TABLE dbo.crtCertificates(
	certificateID int NOT NULL,
	categoryID smallint NULL,
	classID int NULL,
	grade smallint NULL,
	corpID int NULL,
	iconID int NULL,
	description ntext NULL,
 CONSTRAINT crtCertificates_PK PRIMARY KEY  
(
	certificateID ASC
)
) ;


/****** Object:  Table dbo.crtRelationships    Script Date: 11/19/2012 16:39:05 ******/

CREATE TABLE dbo.crtRelationships(
	relationshipID int NOT NULL,
	parentID int NULL,
	parentTypeID int NULL,
	parentLevel smallint NULL,
	childID int NULL,
 CONSTRAINT crtRelationships_relationship PRIMARY KEY  
(
	relationshipID ASC
)
) ;


/****** Object:  Table dbo.crtRecommendations    Script Date: 11/19/2012 16:39:27 ******/

CREATE TABLE dbo.crtRecommendations(
	recommendationID int NOT NULL,
	shipTypeID int NULL,
	certificateID int NULL,
	recommendationLevel smallint NOT NULL,
 CONSTRAINT crtRecommendations_PK PRIMARY KEY  
(
	recommendationID ASC
)
) ;

ALTER TABLE dbo.crtRecommendations ADD  DEFAULT ((0)) FOR recommendationLevel
