
--
-- CHANGE LOG STARTS
----------------------------------
-- CHANGED IN ESCALATION 1.0
----------------------------------
-- invTypes.marketGroupID changed to int
-- invMarketGroups.marketGroupID changed to int
-- invMarketGroups.parentGroupID changed to int
----------------------------------
-- CHANGED IN CRUCIBLE 1.5
----------------------------------
-- invCategories.categoryID changed to int
-- invGroups.groupID changed to int
-- invGroups.categoryID changed to int
-- invTypes.groupID changed to int
-- mapDenormalize.groupID changed to int
-- ramAssemblyLineTypeDetailPerCategory.categoryID changed to int
-- ramAssemblyLineTypeDetailPerGroup.groupID changed to int
----------------------------------
-- CHANGED IN CRUCIBLE 1.1
----------------------------------
-- Removed table agtConfig, all info should be available in agtAgents
-- Removed table translationLaguages, it should never have existed. Proper name is trnTranslationLanguages.
-- Removed column sceneID from mapLocationScenes and replaced it with graphicID representing the nebula graphic.
----------------------------------
-- CHANGED IN CRUCIBLE
----------------------------------
--
-- Removed table dbo.eveOwners
-- Removed table dbo.eveNames
-- Removed table dbo.eveLocations
-- Added table dbo.invNames
-- Added table dbo.invUniqueNames
-- Added table dbo.invPositions
-- The added tables are not fully compatible with the removed ones as EVE has decided to move away
-- from the item/owner/location paradigm.
-- dbo.invNames contains names of all static items with names.
-- dbo.invUniqueNames contains the names of all entities who have a unique name.
--   It is also seekable on the itemName itself and has a unique constraint on that key.
-- dbo.invPositions contains the (x, y, z) coordinate of static items.
--
--
-- Translation Changes:
-- LanguageID 'EN' changed to 'EN-US'
-- Added table dbo.translationLaguages for all languages that can be found in dbo.trnTranslations
--
--
-- Removed table agtConfig. All info it used to contain is now reflected in agtAgents.
--    Added bit column isLocator to agtAgents to signify wether the agent can locate characters or not.
--
-- Added Tables for Factional Warfare.
--    dbo.warCombatZones
--    dbo.warCombatZoneSystems      
--
-- I knew it! I see way less HTs in pro-tournaments these days!
--
----------------------------------
-- CHANGED IN INCARNA
----------------------------------
-- Added tables:
-- dbo.invItems     := The basic item attributes of all static items
--                     Please see table definition for special handling of quantity key.
-- dbo.eveOwners    := A list of all proper static owners, their names and type
-- dbo.eveLocations := A list of all static locations, their names, types and coordinates.
-- Note: eveOwners and eveLocations are a subset of eveNames. However, only eveNames entries are enforced as unique.
-- 
-- Adding a whole lot of foreign key constraints to signify the relationship between the new tables and the current ones.
-- Seriously.. am I the only one really tired of all the pro-protoss players being so Colossus reliant in every matchup?!
-- And what the fuck is up with the proposed High Templar nerf?! Can we get a colussus nerf so that people at least attempt to find new plays!
--
----------------------------------
-- CHANGED IN TYRANNIS 1.2
----------------------------------
-- All instances of item typeID / groupID / categoryID changed to 32bit ints (Were 16bit / 16bit / 8bit).
-- invFlags.flagID changed from 8bit to 16bit
-- Affected columns:
--    dbo.crtRecommendations.shipTypeID                         -> 32bit
--    dbo.crtRelationships.parentTypeID                         -> 32bit
--    dbo.agtResearchAgents.typeID                              -> 32bit
--    dbo.chrBloodlines.shipTypeID                              -> 32bit
--    dbo.crpNPCCorporationResearchFields.skillID               -> 32bit
--    dbo.crpNPCCorporationTrades.typeID                        -> 32bit
--    dbo.dgmTypeAttributes.typeID                              -> 32bit
--    dbo.dgmTypeEffects.typeID                                 -> 32bit
--    dbo.eveNames.typeID                                       -> 32bit
--    dbo.invBlueprintTypes.blueprintTypeID                     -> 32bit
--    dbo.invBlueprintTypes.parentBlueprintTypeID               -> 32bit
--    dbo.invBlueprintTypes.productTypeID                       -> 32bit
--    dbo.invControlTowerResources.controlTowerTypeID           -> 32bit
--    dbo.invControlTowerResources.resourveTypeID               -> 32bit
--    dbo.invContrabandTypes.typeID                             -> 32bit
--    dbo.invFlags.flagID                                       -> 16bit
--    dbo.invMetaTypes.typeID                                   -> 32bit
--    dbo.invMetaTypes.parentTypeID                             -> 32bit
--    dbo.invTypeReactions.typeID                               -> 32bit
--    dbo.invTypes.typeID                                       -> 32bit
--    dbo.invTypeMaterials.typeID                               -> 32bit
--    dbo.invTypeMaterials.materialTypeID                       -> 32bit
--    dbo.mapDenormalize.typeID                                 -> 32bit
--    dbo.mapSolarSystems.sunTypeID                             -> 32bit
--    dbo.ramInstallationTypeContents.installationTypeID        -> 32bit
--    dbo.ramTypeRequirements.typeID                            -> 32bit
--    dbo.ramTypeRequirements.requiredTypeID                    -> 32bit
--    dbo.ramAssemblyLineStations.stationTypeID                 -> 32bit
--    dbo.staStations.stationTypeID                             -> 32bit
--    dbo.staOperations.caldariStationTypeID                    -> 32bit
--    dbo.staOperations.minmatarStationTypeID                   -> 32bit
--    dbo.staOperations.amarrStationTypeID                      -> 32bit
--    dbo.staOperations.gallenteStationTypeID                   -> 32bit
--    dbo.staOperations.joveStationTypeID                       -> 32bit
--    dbo.staStationTypes.statioTypeID                          -> 32bit
--    dbo.planetSchematicsPinMap.pinTypeID                      -> 32bit
--    dbo.planetSchematicsTypeMap.typeID                        -> 32bit    

----------------------------------
-- CHANGED IN TYRANNIS 1.0.2
----------------------------------
-- NON BACKWARDS COMPATIBLE CHANGES BELOW!
-- Adding table eveIcons for 2D graphics.
-- Table eveGraphics recreated for 3D graphics alone.
-- Removing graphicID (3D) and adding iconID (2D) for the following tables:
--   mapLandmarks, chrAncestries, chrAttributes, chrBloodlines, chrRaces, dgmAttributeTypes, dgmEffects, invCategories, invGroups, invMarketGroups, invMetaGroups, 
-- tables with iconID (2D) added:
--   invTypes, chrFactions, crpNPCCorporations
-- tables that retained graphicID:
--   invTypes


----------------------------------
-- CHANGED IN TYRANNIS
----------------------------------
--- added planetSchematics for planets schematics
--- added planetSchematicsPinMap for mapping of pins to planets schematics
--- added planetSchematicsTypeMap type mapping to planets schematics


----------------------------------
-- CHANGED IN DOMINION
----------------------------------
-- Added crtRecommendations for certificate ship recommendations.
-- Added ramTypeRequirements for requirements for S&I activities
-- Added invTypeMaterials for type material composition
-- Added ramBlueprintTypes for extra blueprint type information
-- Added mapLocationWormholeClasses for wormhole classes. regionID > constellationID > systemID 
--       meaning that if the ID is a region every constellation/system in it has the same ID unless otherwise specified.
-- Added mapLocationScenes which controls what skybox is loaded on what place. locationID := systemID.
-- Removed table typeActivityMaterials, replaced it with the parent tables that create the view.
-- Added table ramInstallationTypeContents for assembly line information of different types.
-- Added table dbo.crpNPCCorporationTrades which lists what NPC corps sell what item.
-- Renamed agtAgents.stationID to locationID. Space pigs will now have a systemID there rather than a NULL.

-- Removed table chrCareers
-- Removed table chrCareerSpecialities
-- Removed table chrRaceSkills
-- Removed table chrSchools
-- Removed table chrSchoolAgents

----------------------------------
-- ADDED IN APOCRYPHA 1.5
----------------------------------
-- Translation support
-- Table trnTranslations contains the translation of text columns into different languages according to languageID
-- Table trnTranslationColumns lists the tcID of a given column in a given table.
-- Added reprocessing information for criminal tags


----------------------------------
-- ADDED IN APOCRYPHA 1.3.1_1
----------------------------------
-- Added skill requirements for certificates to the dump

----------------------------------
-- CHANGED IN APOCRYPHA 1.2
----------------------------------
-- crtCertificates.categoryID changed to smallint

----------------------------------
-- REMOVED IN APOCRYPHA 1.2
----------------------------------
-- Table chrCareerSkills
-- Table chrCareerSpecialitySkills
-- Careers and Specialities have no impact on skills post-Apocrypha.

----------------------------------
-- ADDED IN APOCRYPHA
----------------------------------
-- KEY ADDITIONS
-- crpNPCCorporations.description
--
--
----------------------------------
-- REMOVED IN APOCRYPHA
----------------------------------
-- invBlueprintTypes.chanceOfReverseEngineering
-- All dgmTypeAttributes records for category = 11 (entities) or group = 988 (wormholes)

----------------------------------
-- ADDED IN QUANTUM RISE
----------------------------------

-- TABLE ADDITIONS
--
-- CERTIFICATES
-- See below for further explanations.
--
-- crtCategories
-- crtClasses
-- crtRelationships
-- crtCertificates


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
------- FIRST ORDER OF BUSINESS: FREE HONEY FOR EVERYONE! YAY MAYOR BEE! -------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


----------------------------------
-- ADDED SINCE EMPYREAN AGE 1.0
----------------------------------

-- FEATURE ADDITIONS
----------------------------------
-- Added Foreign Key definitions
-- NOTE: The dump does NOT come with FKs to facilitate exports into other formats.
-- The definitions are included below for people who'd like to have them. Use whatever find/replace function that supports regex's
-- to remove the comments (or do it manually, your time not mine).
----------------------------------


-- DEFECTS ADDRESSED
----------------------------------
-- Missing table invControlTowerResources added to the dump (was empty).
----------------------------------


-- KEY ADDITIONS
----------------------------------
-- Added recycle bit to typeActivityMaterials
-- 1 := this required materials is reprocessed into it's material components upon the reprocession of the type
--      that requires this material. The reprocessed materials are then added to the material requirements of the
--      type that is being reprocessed (who can be negative) and returned in the reprocess process.
--      Example: Reprocessing a Guardian will reprocess the Augoror required to make a Guardian.
--               These materials are then added to the Augorors bill of materials. Tritanium, for one, is negative in the
--               Augorors BOM so the difference between the two is payed out.
--               Yes, that means you never get the materials used to build the Augoror from the Guardian only the difference between them,
--               the material from the Guardian which was not used to make the Augoror. Funky, huh?
----------------------------------


-- KEY CHANGES
----------------------------------
-- The following keys had their data types changed for the sake of uniformity.
--
-- agtAgents.divisionID is now smallint
-- chrCareerSpecialities.graphicID is now smallint
-- chrRaces.graphicID is now smallint
-- chrSchools.graphicID is now smallint
-- dgmEffects.falloffAttributeID is now smallint
-- dgmEffects.npcUsageChanceAttributeID is now smallint
-- dgmEffects.npcActivationChanceAttributeID is now smallint
-- dgmEffects.fittingUsageChanceAttributeID is now smallint
-- dgmTypeAttributes.typeID is now smallint
-- dgmTypeEffects.typeID is now smallint
-- eveNames.groupID is now smallint
-- invBlueprintTypes.blueprintTypeID is now smallint
-- invBlueprintTypes.parentBlueprintTypeID is now smallint
-- invBlueprintTypes.productTypeID is now smallint
-- invContrabandTypes.typeID is now smallint
-- invControlTowerResources.controlTowerTypeID is now smallint
-- invControlTowerResources.resourceTypeID is now smallint
-- invMetaTypes.typeID is now smallint
-- invMetaTypes.parentTypeID is now smallint
-- invTypes.groupID is now smallint
-- mapDenormalize.groupID is now smallint
-- staStationTypes.stationTypeID is now smallint
----------------------------------


-- KEY REMOVALS
----------------------------------
-- The following keys are considered legacy data (or just for 3rd party tools) 
-- and were removed to reduce confusion and dump size.
-- chrCareerSpecialities.departmentID
-- chrSchools.agentID
-- crpNPCCorporationDivisions.divisionNumber
-- crpNPCCorporationDivisions.leaderID
-- crpNPCCorporationResearchFields.supplierTypes
-- crpNPCCorporations.mainActivityID;
-- crpNPCCorporations.secondaryActivityID; 
-- dgmAttributeTypes.attributeCategory;
-- dgmAttributeTypes.attributeIdx;
-- dgmAttributeTypes.maxAttributeID;
-- dgmAttributeTypes.chargeRechargeTimeID; 

----------------------------------

--
-- CHANGE LOG ENDS
--

-- TRANSLATIONS
-- trnTranslations
IF OBJECT_ID (dbo.trnTranslations) IS NOT NULL
  DROP TABLE dbo.trnTranslations
;
CREATE TABLE dbo.trnTranslations
(
  tcID        smallint       NOT NULL,
  keyID       int            NOT NULL,
  languageID  varchar(50)    NOT NULL,
  [text]      varchar(max)  NOT NULL,
  
  CONSTRAINT trnTranslations_PK PRIMARY KEY CLUSTERED(tcID, keyID, languageID)
)
;

-- trnTranslationColumns
IF OBJECT_ID ('dbo.trnTranslationColumns) IS NOT NULL
  DROP TABLE dbo.trnTranslationColumns
;
CREATE TABLE dbo.trnTranslationColumns
(
  tcGroupID      smallint       NULL,
  tcID           smallint       NOT NULL,
  tableName      varchar(256)  NOT NULL,
  columnName     varchar(128)  NOT NULL,
  masterID       varchar(128)  NULL,

  CONSTRAINT translationColumns_PK PRIMARY KEY CLUSTERED (tcID)
)
;

-- translationLaguages
IF OBJECT_ID(dbo.trnTranslationLanguages) IS NOT NULL
  DROP TABLE dbo.trnTranslationLanguages
;
CREATE TABLE dbo.trnTranslationLanguages
(
    numericLanguageID   int            NOT NULL,
    languageID          varchar(50)    NULL,
    languageName        varchar(200)  NULL,
    
    CONSTRAINT trnTranslationLanguages_PK PRIMARY KEY CLUSTERED (numericLanguageID) 
)
;


-- CERTIFICATES
-- Certificate Categories
IF OBJECT_ID ('dbo.crtCategories) IS NOT NULL
  DROP TABLE dbo.crtCategories
;
CREATE TABLE dbo.crtCategories
(
  categoryID   smallint,
  description  varchar(500),
  categoryName varchar(256),
  
  CONSTRAINT crtCategories_PK PRIMARY KEY CLUSTERED (categoryID)
)
;

-- Certificate classes (groups)
IF OBJECT_ID ('dbo.crtClasses) IS NOT NULL
  DROP TABLE dbo.crtClasses
;
CREATE TABLE dbo.crtClasses
(
  classID      int,
  description  varchar(500),
  className    varchar(256),
  
  CONSTRAINT crtClasses_PK PRIMARY KEY CLUSTERED (classID)
)
;


-- planet schematics tables
IF OBJECT_ID ('dbo.planetSchematics) IS NOT NULL
  DROP TABLE dbo.planetSchematics
;
CREATE TABLE dbo.planetSchematics
(
  schematicID     smallint,
  schematicName   varchar(255),
  cycleTime       int,

  CONSTRAINT planetSchematics_PK PRIMARY KEY CLUSTERED (schematicID)
)
;

IF OBJECT_ID ('dbo.planetSchematicsPinMap) IS NOT NULL
  DROP TABLE dbo.planetSchematicsPinMap
;
CREATE TABLE dbo.planetSchematicsPinMap
(
  schematicID     smallint,
  pinTypeID       int,

  CONSTRAINT planetSchematicsPinMap_PK PRIMARY KEY CLUSTERED (schematicID, pinTypeID)
)
;

IF OBJECT_ID ('dbo.planetSchematicsTypeMap) IS NOT NULL
  DROP TABLE dbo.planetSchematicsTypeMap
;
CREATE TABLE dbo.planetSchematicsTypeMap
(
  schematicID     smallint,
  typeID          int,
  quantity        smallint,
  isInput         bit,

  CONSTRAINT planetSchematicsTypeMap_PK PRIMARY KEY CLUSTERED (schematicID, typeID)
)
;


-- Certificate relationships
-- ParentID = Required certificateID
-- ParentTypeID = Required skill typeID
  -- parentLevel = Level of skill (parentTypeID) required
-- childID = CertificateID of certificates requiring this certificate
IF OBJECT_ID ('dbo.crtRelationships) IS NOT NULL
  DROP TABLE dbo.crtRelationships
;
CREATE TABLE dbo.crtRelationships
(
  relationshipID    int,
  parentID          int,
  parentTypeID      int,
  parentLevel       smallint,
  childID           int,

  CONSTRAINT crtRelationships_relationship PRIMARY KEY CLUSTERED (relationshipID)
)
CREATE NONCLUSTERED INDEX crtRelationships_IX_parent ON dbo.crtRelationships(parentID)
CREATE NONCLUSTERED INDEX crtRelationships_IX_child ON dbo.crtRelationships(childID)
;

-- Certificates
-- Grade = Certificate level
IF OBJECT_ID ('dbo.crtCertificates) IS NOT NULL
  DROP TABLE dbo.crtCertificates
;
CREATE TABLE dbo.crtCertificates
(
  certificateID       int,
  categoryID          smallint,
  classID             int,
  grade               smallint,
  corpID              int,
  iconID              int,
  description         varchar(500),

  CONSTRAINT crtCertificates_PK PRIMARY KEY CLUSTERED (certificateID)
)
CREATE NONCLUSTERED INDEX crtCertificates_IX_category ON dbo.crtCertificates(categoryID)
CREATE NONCLUSTERED INDEX crtCertificates_IX_class ON dbo.crtCertificates(classID)
;

-- Certificate Reccomendations

IF OBJECT_ID(dbo.crtRecommendations) IS NOT NULL
  DROP TABLE dbo.crtRecommendations
;
CREATE TABLE dbo.crtRecommendations
(
  recommendationID      int       NOT NULL,
  shipTypeID            int       NULL,
  certificateID         int       NULL,
  recommendationLevel   smallint   NOT NULL DEFAULT(0),
  
  CONSTRAINT crtRecommendations_PK PRIMARY KEY CLUSTERED (recommendationID)
)
CREATE NONCLUSTERED INDEX crtRecommendations_IX_shipType ON crtRecommendations (shipTypeID)
CREATE NONCLUSTERED INDEX crtRecommendations_IX_certificate ON crtRecommendations (certificateID)
;


-- AGENTS
-- Agents
IF OBJECT_ID(dbo.agtAgents) IS NOT NULL
  DROP TABLE dbo.agtAgents
;
CREATE TABLE dbo.agtAgents
(
  agentID        int,
  divisionID     smallint,
  corporationID  int,
  locationID     int,
  [level]        smallint,
  quality        smallint,
  agentTypeID    int,
  isLocator      bit,

  CONSTRAINT agtAgents_PK PRIMARY KEY CLUSTERED (agentID)
)
CREATE NONCLUSTERED INDEX agtAgents_IX_corporation ON agtAgents (corporationID)
CREATE NONCLUSTERED INDEX agtAgents_IX_station ON agtAgents (locationID)
;

-- Research agents and their fields
-- This is new. If agent has a science skill it can research that field.
IF OBJECT_ID(dbo.agtResearchAgents) IS NOT NULL
  DROP TABLE dbo.agtResearchAgents
;
CREATE TABLE dbo.agtResearchAgents
(
  agentID      int,
  typeID       int,

  CONSTRAINT agtResearchAgents_PK PRIMARY KEY CLUSTERED (agentID, typeID)
)
CREATE NONCLUSTERED INDEX agtResearchAgents_IX_type ON dbo.agtResearchAgents (typeID)
;

-- Agent Types
IF OBJECT_ID(dbo.agtAgentTypes) IS NOT NULL
  DROP TABLE dbo.agtAgentTypes
;
CREATE TABLE dbo.agtAgentTypes
(
  agentTypeID  int,
  agentType    varchar(50),
  
  CONSTRAINT agtAgentTypes_PK PRIMARY KEY CLUSTERED (agentTypeID)
)
;


-- CHARACTER
-- Character creation relevant tables.
-- Ancestries
IF OBJECT_ID(dbo.chrAncestries) IS NOT NULL
  DROP TABLE dbo.chrAncestries
;
CREATE TABLE dbo.chrAncestries
(
  ancestryID        smallint,
  ancestryName      varchar(100),
  bloodlineID       smallint,
  description       varchar(1000),
  perception        smallint,
  willpower         smallint,
  charisma          smallint,
  memory            smallint,
  intelligence      smallint,
  iconID            int,
  shortDescription  varchar(500),

  CONSTRAINT chrAncestries_PK PRIMARY KEY CLUSTERED (ancestryID)
)
;

-- Attributes
IF OBJECT_ID(dbo.chrAttributes) IS NOT NULL
  DROP TABLE dbo.chrAttributes
;
CREATE TABLE dbo.chrAttributes
(
  attributeID       smallint,
  attributeName     varchar(100),
  description       varchar(1000),
  iconID            int,
  shortDescription  varchar(500),
  notes             varchar(500),

  CONSTRAINT chrAttributes_PK PRIMARY KEY CLUSTERED (attributeID)
)
;

-- Bloodlines
IF OBJECT_ID(dbo.chrBloodlines) IS NOT NULL
  DROP TABLE dbo.chrBloodlines
;
CREATE TABLE dbo.chrBloodlines
(
  bloodlineID             smallint,
  bloodlineName           varchar(100),
  raceID                  smallint,
  description             varchar(1000),
  maleDescription         varchar(1000),
  femaleDescription       varchar(1000),
  shipTypeID              int,
  corporationID           int,

  perception              smallint,
  willpower               smallint,
  charisma                smallint,
  memory                  smallint,
  intelligence            smallint,

  iconID                  int,       

  shortDescription        varchar(500),
  shortMaleDescription    varchar(500),
  shortFemaleDescription  varchar(500),

  CONSTRAINT chrBloodlines_PK PRIMARY KEY CLUSTERED (bloodlineID)
)
;

-- Factions
IF OBJECT_ID(dbo.chrFactions) IS NOT NULL
  DROP TABLE dbo.chrFactions
;
CREATE TABLE dbo.chrFactions
(
  factionID             int,
  factionName           varchar(100),
  description           varchar(1000),
  raceIDs               int,
  solarSystemID         int,
  corporationID         int,
  sizeFactor            real,
  stationCount          smallint,
  stationSystemCount    smallint,
  militiaCorporationID  int,
  iconID                int,

  CONSTRAINT chrFactions_PK PRIMARY KEY CLUSTERED (factionID)
)
;

-- Races
IF OBJECT_ID(dbo.chrRaces) IS NOT NULL
  DROP TABLE dbo.chrRaces
;
CREATE TABLE dbo.chrRaces
(
  raceID            smallint,
  raceName          varchar(100),
  description       varchar(1000),
  iconID            int,
  shortDescription  varchar(500),

  CONSTRAINT chrRaces_PK PRIMARY KEY CLUSTERED (raceID)  
)
;

-- CORPORATIONS
-- Activities
IF OBJECT_ID(dbo.crpActivities) IS NOT NULL
  DROP TABLE dbo.crpActivities
;
CREATE TABLE dbo.crpActivities
(
  activityID      smallint,
  activityName    varchar(100),
  description     varchar(1000),

  CONSTRAINT crpActivities_PK PRIMARY KEY CLUSTERED (activityID)
)
;


-- crpNPCCorporationDivisions
IF OBJECT_ID(dbo.crpNPCCorporationDivisions) IS NOT NULL
  DROP TABLE dbo.crpNPCCorporationDivisions
;
CREATE TABLE dbo.crpNPCCorporationDivisions
(
  corporationID   int,
  divisionID      smallint,
  [size]          smallint,

  CONSTRAINT crpNPCCorporationDivisions_PK PRIMARY KEY CLUSTERED (corporationID, divisionID)
)
;


-- Research Fields
IF OBJECT_ID(dbo.crpNPCCorporationResearchFields) IS NOT NULL
  DROP TABLE dbo.crpNPCCorporationResearchFields
;
CREATE TABLE dbo.crpNPCCorporationResearchFields
(
  skillID        int,
  corporationID  int,

  CONSTRAINT crpNPCCorporationResearchFields_PK PRIMARY KEY CLUSTERED (skillID, corporationID)
)
;


-- NPCCorporations
IF OBJECT_ID(dbo.crpNPCCorporations) IS NOT NULL
  DROP TABLE dbo.crpNPCCorporations
;
CREATE TABLE dbo.crpNPCCorporations
(
  corporationID        int,
  [size]               char(1),
  extent               char(1),
  solarSystemID        int,
  investorID1          int,     
  investorShares1      smallint,
  investorID2          int,
  investorShares2      smallint,
  investorID3          int,
  investorShares3      smallint,
  investorID4          int,
  investorShares4      smallint,
  friendID             int,
  enemyID              int,
  publicShares         bigint,
  initialPrice         int,
  minSecurity          real,
  scattered            bit,
  fringe               smallint,
  corridor             smallint,
  hub                  smallint,
  border               smallint,
  factionID            int,
  sizeFactor           real,
  stationCount         smallint,
  stationSystemCount   smallint,
  description          varchar(4000),
  iconID               int,

  CONSTRAINT crpNPCCorporations_PK PRIMARY KEY CLUSTERED (corporationID)
)
;

-- Divisions
IF OBJECT_ID(dbo.crpNPCDivisions) IS NOT NULL
  DROP TABLE dbo.crpNPCDivisions
;
CREATE TABLE dbo.crpNPCDivisions
(
  divisionID    smallint,
  divisionName  varchar(100),
  description   varchar(1000),
  leaderType    varchar(100),

  CONSTRAINT crpNPCDivisions_PK PRIMARY KEY CLUSTERED (divisionID)
)
;

-- Trade info
IF OBJECT_ID(dbo.crpNPCCorporationTrades) IS NOT NULL
  DROP TABLE dbo.crpNPCCorporationTrades
;
CREATE TABLE dbo.crpNPCCorporationTrades
(
  corporationID  int,
  typeID         int,
  
  CONSTRAINT crpNPCCorporationTrades_PK PRIMARY KEY CLUSTERED (corporationID, typeID)
)
;



-- DOGMA
-- Attributes
IF OBJECT_ID(dbo.dgmAttributeTypes) IS NOT NULL
  DROP TABLE dbo.dgmAttributeTypes
;
CREATE TABLE dbo.dgmAttributeTypes
(
  attributeID           smallint,
  attributeName         varchar(100),
  description           varchar(1000),
  iconID                int,
  defaultValue          real,
  published             bit,
  displayName           varchar(100),
  unitID                smallint,
  stackable             bit,
  highIsGood            bit,
  categoryID            smallint,

  CONSTRAINT dgmAttributeTypes_PK PRIMARY KEY CLUSTERED (attributeID)  
)
;

-- Attribute categories
-- Included for convenience, has zero game effect.
IF OBJECT_ID(dbo.dgmAttributeCategories) IS NOT NULL
  DROP TABLE dbo.dgmAttributeCategories
;
CREATE TABLE dbo.dgmAttributeCategories
(
    categoryID           smallint,
    categoryName         varchar(50),
    categoryDescription  varchar(200),  

  CONSTRAINT dgmAttributeCategories_PK PRIMARY KEY CLUSTERED (categoryID)
)
;

-- Type Attributes
IF OBJECT_ID(dbo.dgmTypeAttributes) IS NOT NULL
  DROP TABLE dbo.dgmTypeAttributes
;
CREATE TABLE dbo.dgmTypeAttributes
(
  typeID       int,
  attributeID  smallint,
  valueInt     int,
  valueFloat   real,

  CONSTRAINT dgmTypeAttributes_PK PRIMARY KEY CLUSTERED (typeID, attributeID)
)
;


-- Effects
IF OBJECT_ID(dbo.dgmEffects) IS NOT NULL
  DROP TABLE dbo.dgmEffects
;
CREATE TABLE dbo.dgmEffects
(
  effectID                        smallint,
  effectName                      varchar(400) COLLATE Latin1_General_CI_AI,
  effectCategory                  smallint,
  preExpression                   int,
  postExpression                  int,
  description                     varchar(1000),
  guid                            varchar(60),
  iconID                          int,
  isOffensive                     bit,
  isAssistance                    bit,
  durationAttributeID             smallint,
  trackingSpeedAttributeID        smallint,
  dischargeAttributeID            smallint,
  rangeAttributeID                smallint,
  falloffAttributeID              smallint,
  disallowAutoRepeat              bit,
  published                       bit,
  displayName                     varchar(100),
  isWarpSafe                      bit,
  rangeChance                     bit,
  electronicChance                bit,
  propulsionChance                bit,
  distribution                    smallint,
  sfxName                         varchar(20),
  npcUsageChanceAttributeID       smallint,
  npcActivationChanceAttributeID  smallint,
  fittingUsageChanceAttributeID   smallint,

  CONSTRAINT dgmEffects_PK PRIMARY KEY CLUSTERED (effectID)
)
;

-- Type Effects
IF  OBJECT_ID(dbo.dgmTypeEffects) IS NOT NULL
  DROP TABLE dbo.dgmTypeEffects
;
CREATE TABLE dbo.dgmTypeEffects
(
  typeID      int,
  effectID    smallint,
  isDefault   bit,

  CONSTRAINT dgmTypeEffects_PK PRIMARY KEY CLUSTERED(typeID, effectID)
)
;


-- EVE
-- Owner
IF OBJECT_ID(dbo.eveOwners) IS NOT NULL
  DROP TABLE dbo.eveOwners
;

-- Locations
IF OBJECT_ID(dbo.eveLocations) IS NOT NULL
  DROP TABLE dbo.eveLocations
;

-- Icons
IF OBJECT_ID(dbo.eveIcons) IS NOT NULL
  DROP TABLE dbo.eveIcons
;
CREATE TABLE dbo.eveIcons
(
  iconID         int            NOT NULL,
  iconFile       varchar(500)   NOT NULL  DEFAULT '',
  [description]  varchar(max)  NOT NULL  DEFAULT '',
  
  CONSTRAINT eveIcons_PK PRIMARY KEY CLUSTERED (iconID)
)
;



-- Names
IF OBJECT_ID(dbo.eveNames) IS NOT NULL
  DROP TABLE dbo.eveNames
;

-- Units
IF OBJECT_ID(dbo.eveUnits) IS NOT NULL
  DROP TABLE dbo.eveUnits
;
CREATE TABLE dbo.eveUnits
(
  unitID       smallint,
  unitName     varchar(100),
  displayName  varchar(50),
  description  varchar(1000),

  CONSTRAINT eveUnits_PK PRIMARY KEY CLUSTERED (unitID)
)
;


-- Blueprints
-- Base blueprint information
IF OBJECT_ID(dbo.invBlueprintTypes) IS NOT NULL
  DROP TABLE dbo.invBlueprintTypes
;
CREATE TABLE dbo.invBlueprintTypes
(
   blueprintTypeID             int,

   parentBlueprintTypeID       int,
   productTypeID               int,
   productionTime              int,
   techLevel                   smallint,
   researchProductivityTime    int,
   researchMaterialTime        int,
   researchCopyTime            int,
   researchTechTime            int,
   productivityModifier        int,
   materialModifier            smallint,
   wasteFactor                 smallint,
   maxProductionLimit          int,

  CONSTRAINT invBlueprintTypes_PK PRIMARY KEY CLUSTERED (blueprintTypeID)

)
;

-- POS
-- Control Tower Resources
IF OBJECT_ID(dbo.invControlTowerResources) IS NOT NULL
  DROP TABLE dbo.invControlTowerResources
;
CREATE TABLE dbo.invControlTowerResources
(
  controlTowerTypeID  int,
  resourceTypeID      int,
  --
  purpose             smallint,
  quantity            int,
  minSecurityLevel    real,
  factionID           int,

  CONSTRAINT invControlTowerResources_PK PRIMARY KEY CLUSTERED (controlTowerTypeID, resourceTypeID)
)
;


-- INVENTORY
-- POS Resource Purpose
IF OBJECT_ID(dbo.invControlTowerResourcePurposes) IS NOT NULL
  DROP TABLE dbo.invControlTowerResourcePurposes
;
CREATE TABLE dbo.invControlTowerResourcePurposes
(
  purpose      smallint,
  purposeText  varchar(100),
  --
  CONSTRAINT invControlTowerResourcePurposes_PK PRIMARY KEY CLUSTERED (purpose)
)
;

IF OBJECT_ID(dbo.invItems) IS NOT NULL
  DROP TABLE dbo.invItems
;
CREATE TABLE dbo.invItems
(
    itemID      bigint    NOT NULL,
    typeID      int       NOT NULL,
    ownerID     int       NOT NULL,
    locationID  bigint    NOT NULL,
    flagID      smallint  NOT NULL,
    quantity    int       NOT NULL,  -- Attention! quantity = -1 signifies a non-stackable item with a quantity of 1
                                     -- where as quantity = 1 signifies a stackable item with a quantity of 1
    --
    CONSTRAINT invItems_PK PRIMARY KEY CLUSTERED (itemID)
)
CREATE NONCLUSTERED INDEX items_IX_Location ON invItems (locationID)
CREATE NONCLUSTERED INDEX items_IX_OwnerLocation ON invItems (ownerID, locationID)
;

IF OBJECT_ID(dbo.invUniqueNames) IS NOT NULL
  DROP TABLE dbo.invUniqueNames
;
CREATE TABLE dbo.invUniqueNames
(
  itemID    int                                          NOT NULL,
  itemName  varchar(200)  COLLATE Latin1_General_CI_AI  NOT NULL,
  --
  groupID   int                                          NULL,
  --
  CONSTRAINT invUniqueNames_PK PRIMARY KEY CLUSTERED (itemID)
)
CREATE UNIQUE NONCLUSTERED INDEX invUniqueNames_UQ ON dbo.invUniqueNames (itemName)
CREATE NONCLUSTERED INDEX invUniqueNames_IX_GroupName ON dbo.invUniqueNames (groupID, itemName)
;

IF OBJECT_ID(dbo.invNames) IS NOT NULL
  DROP TABLE dbo.invNames
;
CREATE TABLE dbo.invNames
(
    itemID     bigint         NOT NULL,
    itemName   varchar(200)  NOT NULL,
    
    CONSTRAINT invNames_PK PRIMARY KEY CLUSTERED (itemID)
)
;

IF OBJECT_ID(dbo.invPositions) IS NOT NULL
  DROP TABLE dbo.invPositions
;
CREATE TABLE dbo.invPositions
(
    itemID  bigint  NOT NULL,
    x       real   NOT NULL  DEFAULT 0.0,
    y       real   NOT NULL  DEFAULT 0.0,
    z       real   NOT NULL  DEFAULT 0.0,
    yaw     real    NULL,
    pitch   real    NULL,
    roll    real    NULL,
    --
    CONSTRAINT invPositions_PK PRIMARY KEY CLUSTERED (itemID)
)
;

-- Categories
IF OBJECT_ID(dbo.invCategories) IS NOT NULL
  DROP TABLE dbo.invCategories
;
CREATE TABLE dbo.invCategories
(
  categoryID    int,
 
  categoryName  varchar(100)   COLLATE Latin1_General_CI_AI,
  description   varchar(3000),
  iconID        int,
  published     bit,

  CONSTRAINT invCategories_PK PRIMARY KEY CLUSTERED (categoryID)
)
;

-- Contraband
IF OBJECT_ID(dbo.invContrabandTypes) IS NOT NULL
  DROP TABLE dbo.invContrabandTypes
;
CREATE TABLE dbo.invContrabandTypes
(
  factionID         int,
  typeID            int,

  standingLoss      real,
  confiscateMinSec  real,
  fineByValue       real,
  attackMinSec      real,

  CONSTRAINT invContrabandTypes_PK PRIMARY KEY CLUSTERED (factionID, typeID)
)
  CREATE NONCLUSTERED INDEX invContrabandTypes_IX_type ON dbo.invContrabandTypes (typeID)
;

-- Flags
IF OBJECT_ID(dbo.invFlags) IS NOT NULL
  DROP TABLE dbo.invFlags
;
CREATE TABLE dbo.invFlags
(
  flagID    smallint,
  flagName  varchar(200),
  flagText  varchar(100),
  orderID   int,

  CONSTRAINT invFlags_PK PRIMARY KEY CLUSTERED (flagID)
)
;

-- Groups
IF OBJECT_ID(dbo.invGroups) IS NOT NULL
  DROP TABLE dbo.invGroups
;
CREATE TABLE dbo.invGroups
(
  groupID               int,
  --
  categoryID            int,
  groupName             varchar(100)   COLLATE Latin1_General_CI_AI,
  description           varchar(3000),
  iconID                int,
  useBasePrice          bit,
  allowManufacture      bit,
  allowRecycler         bit,
  anchored              bit,
  anchorable            bit,
  fittableNonSingleton  bit,
  published             bit,
  
  CONSTRAINT invGroups_PK PRIMARY KEY CLUSTERED (groupID)
)
  CREATE NONCLUSTERED INDEX invGroups_IX_category ON dbo.invGroups (categoryID)
;


-- Market groups
IF OBJECT_ID(dbo.invMarketGroups) IS NOT NULL
  DROP TABLE dbo.invMarketGroups
;
CREATE TABLE dbo.invMarketGroups
(
  marketGroupID    int,
  --
  parentGroupID    int,
  marketGroupName  varchar(100),
  description      varchar(3000),
  iconID           int,
  hasTypes         bit,

  CONSTRAINT invMarketGroups_PK PRIMARY KEY CLUSTERED (marketGroupID)
)
;

-- Meta Groups
IF OBJECT_ID(dbo.invMetaGroups) IS NOT NULL
  DROP TABLE dbo.invMetaGroups
;
CREATE TABLE dbo.invMetaGroups
(
  metaGroupID    smallint,
  --
  metaGroupName  varchar(100),
  description    varchar(1000),
  iconID         int,

  CONSTRAINT invMetaGroups_PK PRIMARY KEY CLUSTERED (metaGroupID)
)
;

-- Meta Types
IF OBJECT_ID(dbo.invMetaTypes) IS NOT NULL
  DROP TABLE dbo.invMetaTypes
;
CREATE TABLE dbo.invMetaTypes
(
  typeID        int,
  --
  parentTypeID  int,
  metaGroupID   smallint,

  CONSTRAINT invMetaTypes_PK PRIMARY KEY CLUSTERED(typeID)
)
;

-- Type Reactions
IF OBJECT_ID(dbo.invTypeReactions) IS NOT NULL
  DROP TABLE dbo.invTypeReactions
;
CREATE TABLE dbo.invTypeReactions
(
  reactionTypeID  int,
  input           bit,
  typeID          int,
  quantity        smallint,
  --
  CONSTRAINT pk_invTypeReactions PRIMARY KEY CLUSTERED (reactionTypeID, input, typeID)
)


-- Types
IF OBJECT_ID(dbo.invTypes) IS NOT NULL
  DROP TABLE dbo.invTypes
;
CREATE TABLE dbo.invTypes
(
  typeID               int,
  groupID              int,
  typeName             varchar(100)   COLLATE Latin1_General_CI_AI,
  description          varchar(3000),
  mass                 real,
  volume               real,
  capacity             real,
  portionSize          int,
  raceID               smallint,
  basePrice            money,
  published            bit,
  marketGroupID        int,
  chanceOfDuplicating  real,
  iconID               int,
                                 
  CONSTRAINT invTypes_PK PRIMARY KEY CLUSTERED (typeID)
)
CREATE NONCLUSTERED INDEX invTypes_IX_Group ON dbo.invTypes (groupID)
;


IF OBJECT_ID(dbo.invTypeMaterials) IS NOT NULL
  DROP TABLE dbo.invTypeMaterials
CREATE TABLE dbo.invTypeMaterials
(
  typeID          int  NOT NULL,
  materialTypeID  int  NOT NULL,
  --
  quantity        int  NOT NULL  DEFAULT 0,
  --
  CONSTRAINT invTypeMaterials_PK PRIMARY KEY CLUSTERED (typeID, materialTypeID)
)



-- MAP

-- mapLocationScenes
IF OBJECT_ID(dbo.mapLocationScenes) IS NOT NULL
  DROP TABLE dbo.mapLocationScenes
CREATE TABLE dbo.mapLocationScenes
(
  locationID  int      NOT NULL,
  --
  graphicID   int      NULL,
  
  CONSTRAINT mapLocationScenes_PK_ PRIMARY KEY CLUSTERED (locationID)
)

-- mapLocationWormholeClasses
IF OBJECT_ID(dbo.mapLocationWormholeClasses) IS NOT NULL
  DROP TABLE dbo.mapLocationWormholeClasses
CREATE TABLE dbo.mapLocationWormholeClasses
(
  locationID       int      NOT NULL,
  --
  wormholeClassID  smallint  NULL,

  CONSTRAINT mapLocationWormholeClasses_PK PRIMARY KEY CLUSTERED (locationID)
)

-- Celestial Statistics
IF OBJECT_ID(dbo.mapCelestialStatistics) IS NOT NULL
  DROP TABLE dbo.mapCelestialStatistics
;
CREATE TABLE dbo.mapCelestialStatistics
(
  celestialID     int,
  temperature     real,
  spectralClass   varchar(10),
  luminosity      real,
  age             real,
  life            real,
  orbitRadius     real,
  eccentricity    real,
  massDust        real,
  massGas         real,
  fragmented      bit,
  density         real,
  surfaceGravity  real,
  escapeVelocity  real,
  orbitPeriod     real,
  rotationRate    real,
  locked          bit,
  pressure        real,
  radius          real,
  mass            real,
  --
  CONSTRAINT mapCelestialStatistics_PK PRIMARY KEY CLUSTERED (celestialID)
)
;

-- Constellation Jumps
IF OBJECT_ID(dbo.mapConstellationJumps) IS NOT NULL
  DROP TABLE dbo.mapConstellationJumps
;
CREATE TABLE dbo.mapConstellationJumps
(
  fromRegionID         int,
  fromConstellationID  int,
  toConstellationID    int,
  toRegionID           int,
  --
  CONSTRAINT mapConstellationJumps_PK PRIMARY KEY CLUSTERED (fromConstellationID, toConstellationID)
)
CREATE NONCLUSTERED INDEX mapConstellationJumps_IX_fromRegion ON mapConstellationJumps(fromRegionID)
;


-- Constellations
IF OBJECT_ID(dbo.mapConstellations) IS NOT NULL
  DROP TABLE dbo.mapConstellations
;
CREATE TABLE dbo.mapConstellations
(
  regionID             int,
  constellationID      int,
  constellationName    varchar(100)  COLLATE Latin1_General_CI_AI,
  x                    real,
  y                    real,
  z                    real,
  xMin                 real,
  xMax                 real,
  yMin                 real,
  yMax                 real,
  zMin                 real,
  zMax                 real,
  factionID            int,
  radius               real,
  --
  CONSTRAINT mapConstellations_PK PRIMARY KEY CLUSTERED (constellationID)
)
CREATE NONCLUSTERED INDEX mapConstellations_IX_region ON mapConstellations(regionID)
;

-- Denormalized Data
IF OBJECT_ID(dbo.mapDenormalize) IS NOT NULL
  DROP TABLE dbo.mapDenormalize
;
CREATE TABLE dbo.mapDenormalize
(
  itemID           int,
  typeID           int,
  groupID          int,
  solarSystemID    int,
  constellationID  int,
  regionID         int,
  orbitID          int,
  x                real,
  y                real,
  z                real,
  radius           real,
  itemName         varchar(100),
  [security]       real,
  celestialIndex   smallint,
  orbitIndex       smallint,
  --
  CONSTRAINT mapDenormalize_PK PRIMARY KEY CLUSTERED (itemID)
)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_groupRegion ON mapDenormalize(groupID, regionID)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_groupConstellation ON mapDenormalize(groupID, constellationID)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_groupSystem ON mapDenormalize(groupID, solarSystemID)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_system ON mapDenormalize(solarSystemID)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_constellation ON mapDenormalize(constellationID)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_region ON mapDenormalize(regionID)
CREATE NONCLUSTERED INDEX mapDenormalize_IX_orbit ON mapDenormalize(orbitID)
;


-- Jumps
IF OBJECT_ID(dbo.mapJumps) IS NOT NULL
  DROP TABLE dbo.mapJumps
;
CREATE TABLE dbo.mapJumps
(
  stargateID   int,
  celestialID  int,
  --
  CONSTRAINT mapJumps_PK PRIMARY KEY CLUSTERED (stargateID)
)
;


-- Landmarks
IF OBJECT_ID(dbo.mapLandmarks) IS NOT NULL
  DROP TABLE dbo.mapLandmarks
;
CREATE TABLE dbo.mapLandmarks
(
  landmarkID    smallint,
  landmarkName  varchar(100),
  description   varchar(7000),
  locationID    int,
  x             real,
  y             real,
  z             real,
  radius        real,
  iconID        int,
  importance    smallint
  --
  CONSTRAINT mapLandmarks_PK PRIMARY KEY CLUSTERED (landmarkID)
)


-- Region Jumps
IF OBJECT_ID(dbo.mapRegionJumps) IS NOT NULL
  DROP TABLE dbo.mapRegionJumps
;
CREATE TABLE dbo.mapRegionJumps
(
  fromRegionID  int  NOT NULL,
  toRegionID    int  NOT NULL,
  --
  CONSTRAINT mapRegionJumps_PK PRIMARY KEY CLUSTERED (fromRegionID, toRegionID)
)
;


-- Regions
IF OBJECT_ID(dbo.mapRegions) IS NOT NULL
  DROP TABLE dbo.mapRegions
;
CREATE TABLE dbo.mapRegions
(
  regionID    int,
  regionName  varchar(100)  COLLATE Latin1_General_CI_AI,
  x           real,
  y           real,
  z           real,
  xMin        real,
  xMax        real,
  yMin        real,
  yMax        real,
  zMin        real,
  zMax        real,
  factionID   int,
  radius      real,
  --
  CONSTRAINT mapRegions_PK PRIMARY KEY CLUSTERED (regionID)
)
;

-- System Jumps
IF OBJECT_ID(dbo.mapSolarSystemJumps) IS NOT NULL
  DROP TABLE dbo.mapSolarSystemJumps
;
CREATE TABLE dbo.mapSolarSystemJumps
(
  fromRegionID         int,
  fromConstellationID  int,
  fromSolarSystemID    int,
  toSolarSystemID      int,
  toConstellationID    int,
  toRegionID           int,
  --
  CONSTRAINT mapSolarSystemJumps_PK PRIMARY KEY CLUSTERED (fromSolarSystemID, toSolarSystemID)
)
CREATE NONCLUSTERED INDEX mapSolarSystemJumps_IX_fromRegion ON mapSolarSystemJumps(fromRegionID)
CREATE NONCLUSTERED INDEX mapSolarSystemJumps_IX_fromConstellation ON mapSolarSystemJumps(fromConstellationID)
;


-- Systems
IF OBJECT_ID(dbo.mapSolarSystems) IS NOT NULL
  DROP TABLE dbo.mapSolarSystems
;
CREATE TABLE dbo.mapSolarSystems
(
  regionID             int,
  constellationID      int,
  solarSystemID        int,
  solarSystemName      varchar(100)  COLLATE Latin1_General_CI_AI,
  x                    real,
  y                    real,
  z                    real,
  xMin                 real,
  xMax                 real,
  yMin                 real,
  yMax                 real,
  zMin                 real,
  zMax                 real,
  luminosity           real,
  --
  border               bit,
  fringe               bit,
  corridor             bit,
  hub                  bit,
  international        bit,
  regional             bit,
  constellation        bit,
  security             real,
  factionID            int,
  radius               real,
  sunTypeID            int,
  securityClass        varchar(2),
  --
  CONSTRAINT mapSolarSystems_PK PRIMARY KEY CLUSTERED (solarSystemID)
)
CREATE NONCLUSTERED INDEX mapSolarSystems_IX_region ON mapSolarSystems(regionID)
CREATE NONCLUSTERED INDEX mapSolarSystems_IX_constellation ON mapSolarSystems(constellationID)
CREATE NONCLUSTERED INDEX mapSolarSystems_IX_security ON mapSolarSystems([security])
;

-- Universe
IF OBJECT_ID(dbo.mapUniverse) IS NOT NULL
  DROP TABLE dbo.mapUniverse
;
CREATE TABLE dbo.mapUniverse
(
  universeID    int,
  universeName  varchar(100),
  x             real,
  y             real,
  z             real,
  xMin          real,
  xMax          real,
  yMin          real,
  yMax          real,
  zMin          real,
  zMax          real,
  radius        real,
  --
  CONSTRAINT mapUniverse_PK PRIMARY KEY CLUSTERED (universeID)
)
;


-- RAM
IF OBJECT_ID(dbo.ramInstallationTypeContents) IS NOT NULL
  DROP TABLE dbo.ramInstallationTypeContents
CREATE TABLE dbo.ramInstallationTypeContents
(
  installationTypeID  int      NOT NULL,
  assemblyLineTypeID  smallint  NOT NULL,
  --
  quantity            smallint  NULL,
  CONSTRAINT ramInstallationTypeContents_PK PRIMARY KEY CLUSTERED (installationTypeID, assemblyLineTypeID)
)
;

-- type requirements
IF OBJECT_ID(dbo.ramTypeRequirements) IS NOT NULL
  DROP TABLE dbo.ramTypeRequirements
CREATE TABLE dbo.ramTypeRequirements
(
  typeID          int      NOT NULL,
  activityID      smallint  NOT NULL,
  requiredTypeID  int      NOT NULL,
  --
  quantity        int      NULL,
  damagePerJob    real    NULL,
  recycle         bit      NULL,
  --
  CONSTRAINT ramTypeRequirements_PK PRIMARY KEY CLUSTERED (typeID, activityID, requiredTypeID)
)

-- Activities
IF OBJECT_ID(dbo.ramActivities) IS NOT NULL
  DROP TABLE dbo.ramActivities
;
CREATE TABLE dbo.ramActivities
(
  activityID     smallint,
  activityName   varchar(100),
  iconNo         varchar(5),
  description    varchar(1000),
  published      bit,
  --
  CONSTRAINT ramActivities_PK PRIMARY KEY CLUSTERED (activityID)
)
;

-- Assembly Lines
IF OBJECT_ID(dbo.ramAssemblyLines) IS NOT NULL
  DROP TABLE dbo.ramAssemblyLines
;
CREATE TABLE dbo.ramAssemblyLines
(
  assemblyLineID                int,
  assemblyLineTypeID            smallint,
  containerID                   int, -- where it is (stationID)
  nextFreeTime                  smalldatetime,
  UIGroupingID                  smallint, --user defined groupings (within a containment)
  costInstall                   real,
  costPerHour                   real,
  restrictionMask               smallint, -- (0 = not, 1 = by security, 2 = by standing, 4 = corp, 8 = alliance)
  discountPerGoodStandingPoint  real,
  surchargePerBadStandingPoint  real,
  minimumStanding               real,
  minimumCharSecurity           real,
  minimumCorpSecurity           real,
  maximumCharSecurity           real,
  maximumCorpSecurity           real,
  ownerID                       int,
  activityID                    smallint,
  --
  CONSTRAINT ramAssemblyLines_PK PRIMARY KEY CLUSTERED (assemblyLineID)
)
CREATE NONCLUSTERED INDEX ramAssemblyLines_IX_container ON ramAssemblyLines (containerID)
CREATE NONCLUSTERED INDEX ramAssemblyLines_IX_owner ON ramAssemblyLines (ownerID)
;

-- Assembly Lines by Station
IF OBJECT_ID(dbo.ramAssemblyLineStations) IS NOT NULL
  DROP TABLE dbo.ramAssemblyLineStations
;
CREATE TABLE dbo.ramAssemblyLineStations
(
  stationID           int,
  assemblyLineTypeID  smallint,
  quantity            smallint,
  stationTypeID       int,
  ownerID             int,
  solarSystemID       int,
  regionID            int,
  --
  CONSTRAINT ramAssemblyLineStations_PK PRIMARY KEY CLUSTERED (stationID, assemblyLineTypeID)
)
CREATE NONCLUSTERED INDEX ramAssemblyLineStations_IX_region ON ramAssemblyLineStations (regionID)
CREATE NONCLUSTERED INDEX ramAssemblyLineStations_IX_owner ON ramAssemblyLineStations (ownerID)

;


-- Assembly Line Type Details Per Category
IF OBJECT_ID(dbo.ramAssemblyLineTypeDetailPerCategory) IS NOT NULL
  DROP TABLE dbo.ramAssemblyLineTypeDetailPerCategory
;
CREATE TABLE dbo.ramAssemblyLineTypeDetailPerCategory
(
  assemblyLineTypeID  smallint,
  categoryID          int,
  timeMultiplier      real,
  materialMultiplier  real,
  --
  CONSTRAINT ramAssemblyLineTypeDetailPerCategory_PK PRIMARY KEY CLUSTERED (assemblyLineTypeID, categoryID)
)
;


-- ramAssemblyLineTypeDetailPerGroup
IF OBJECT_ID(dbo.ramAssemblyLineTypeDetailPerGroup) IS NOT NULL
  DROP TABLE dbo.ramAssemblyLineTypeDetailPerGroup
;
CREATE TABLE dbo.ramAssemblyLineTypeDetailPerGroup
(
  assemblyLineTypeID  smallint,
  groupID             int,
  timeMultiplier      real,
  materialMultiplier  real,
  --
  CONSTRAINT ramAssemblyLineTypeDetailPerGroup_PK PRIMARY KEY CLUSTERED (assemblyLineTypeID, groupID)
)
;

-- Assembly Line Types
IF OBJECT_ID(dbo.ramAssemblyLineTypes) IS NOT NULL
  DROP TABLE dbo.ramAssemblyLineTypes
;
CREATE TABLE dbo.ramAssemblyLineTypes
(
  assemblyLineTypeID      smallint,
  assemblyLineTypeName    varchar(100),
  description             varchar(1000),
  baseTimeMultiplier      real,
  baseMaterialMultiplier  real,
  volume                  real,
  activityID              smallint,
  minCostPerHour          real,
  --
  CONSTRAINT ramAssemblyLineTypes_PK PRIMARY KEY CLUSTERED (assemblyLineTypeID)
)
;

-- STATIONS
-- Operations
IF OBJECT_ID(dbo.staOperations) IS NOT NULL
  DROP TABLE dbo.staOperations
;
CREATE TABLE dbo.staOperations
(
  activityID             smallint,
  operationID            smallint,
  operationName          varchar(100),
  description            varchar(1000),
  fringe                 smallint,
  corridor               smallint,
  hub                    smallint,
  border                 smallint,
  ratio                  smallint,
  caldariStationTypeID   int,
  minmatarStationTypeID  int,
  amarrStationTypeID     int,
  gallenteStationTypeID  int,
  joveStationTypeID      int,
  --
  CONSTRAINT staOperations_PK PRIMARY KEY CLUSTERED (operationID)
)
;

-- Operation Services
IF OBJECT_ID(dbo.staOperationServices) IS NOT NULL
  DROP TABLE dbo.staOperationServices
;
CREATE TABLE dbo.staOperationServices
(
  operationID  smallint,
  serviceID    int,
  --
  CONSTRAINT staOperationServices_PK PRIMARY KEY CLUSTERED (operationID, serviceID)
)
;

-- Services
IF OBJECT_ID(dbo.staServices) IS NOT NULL
  DROP TABLE dbo.staServices
;
CREATE TABLE dbo.staServices
(
  serviceID    int,
  serviceName  varchar(100),
  description  varchar(1000),
  --
  CONSTRAINT staServices_PK PRIMARY KEY CLUSTERED (serviceID)
)
;


-- Stations
IF OBJECT_ID(dbo.staStations) IS NOT NULL
  DROP TABLE dbo.staStations
;
CREATE TABLE dbo.staStations
(
  stationID                 int,
  [security]                smallint,
  dockingCostPerVolume      real,
  maxShipVolumeDockable     real,
  officeRentalCost          int,
  operationID               smallint,
  -- DENORMALIZED DATA
  stationTypeID             int,
  corporationID             int,
  solarSystemID             int,
  constellationID           int,
  regionID                  int,
  stationName               varchar(100)  COLLATE Latin1_General_CI_AI,
  x                         real,
  y                         real,
  z                         real,
  reprocessingEfficiency    real,
  reprocessingStationsTake  real,
  reprocessingHangarFlag    smallint,
  --
  CONSTRAINT staStations_PK PRIMARY KEY CLUSTERED (stationID)
)
CREATE NONCLUSTERED INDEX staStations_IX_region ON staStations (regionID)
CREATE NONCLUSTERED INDEX staStations_IX_system ON staStations (solarSystemID)
CREATE NONCLUSTERED INDEX staStations_IX_constellation ON staStations (constellationID)
CREATE NONCLUSTERED INDEX staStations_IX_operation ON staStations (operationID)
CREATE NONCLUSTERED INDEX staStations_IX_type ON staStations (stationTypeID)
CREATE NONCLUSTERED INDEX staStations_IX_corporation ON staStations (corporationID)
;

-- Types
IF OBJECT_ID(dbo.staStationTypes) IS NOT NULL
  DROP TABLE dbo.staStationTypes
;
CREATE TABLE dbo.staStationTypes
(
  stationTypeID           int,
  --
  dockEntryX              real,
  dockEntryY              real,
  dockEntryZ              real,
  dockOrientationX        real,
  dockOrientationY        real,
  dockOrientationZ        real,
  operationID             smallint,
  officeSlots             smallint,
  reprocessingEfficiency  real,
  conquerable             bit,
  --
  CONSTRAINT stationTypes_PK PRIMARY KEY CLUSTERED (stationTypeID)
)
;

-- Factional Warfare
IF OBJECT_ID(dbo.warCombatZones) IS NOT NULL
  DROP TABLE dbo.warCombatZones
;
CREATE TABLE dbo.warCombatZones
(
  combatZoneID    int            NOT NULL DEFAULT -1,
  combatZoneName  varchar(100)  NULL,
  factionID       int            NULL,
  centerSystemID  int            NULL,
  description     varchar(500)  NULL,
  CONSTRAINT combatZones_PK PRIMARY KEY CLUSTERED (combatZoneID)
)
;

IF OBJECT_ID(dbo.warCombatZoneSystems) IS NOT NULL
  DROP TABLE dbo.warCombatZoneSystems
;
CREATE TABLE dbo.warCombatZoneSystems
(
  solarSystemID  int      NOT NULL,
  combatZoneID   int      NULL,

  CONSTRAINT combatZoneSystems_PK PRIMARY KEY CLUSTERED (solarSystemID)    
)
;


---
--- FOREIGN KEYS
---

/*
ALTER TABLE dbo.crtRelationships ADD CONSTRAINT crtRelationships_FK_child  FOREIGN KEY (childID) REFERENCES dbo.crtCertificates(certificateID)

ALTER TABLE dbo.crtRecommendations ADD CONSTRAINT crtRecommendations_FK_shipType FOREIGN KEY (shipTypeID) REFERENCES dbo.invTypes(typeID)
ALTER TABLE dbo.crtRecommendations ADD CONSTRAINT crtRecommendations_FK_certificate FOREIGN KEY (certificateID) REFERENCES dbo.crtCertificates(certificateID)

ALTER TABLE dbo.crtCertificates ADD CONSTRAINT crtCertificates_FK_category FOREIGN KEY (categoryID) REFERENCES crtCategories(categoryID)
ALTER TABLE dbo.crtCertificates ADD CONSTRAINT crtCertificates_FK_class FOREIGN KEY (classID) REFERENCES crtClasses(classID)
ALTER TABLE dbo.crtCertificates ADD CONSTRAINT crtCertificates_FK_corp FOREIGN KEY (corpID) REFERENCES dbo.crpNPCCorporations(corporationID)

ALTER TABLE agtAgents ADD CONSTRAINT agtAgents_FK_agent FOREIGN KEY (agentID) REFERENCES invNames(itemID)
ALTER TABLE agtAgents ADD CONSTRAINT agtAgents_FK_division FOREIGN KEY (divisionID) REFERENCES crpNPCDivisions(divisionID)
ALTER TABLE agtAgents ADD CONSTRAINT agtAgents_FK_corporation FOREIGN KEY (corporationID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE agtAgents ADD CONSTRAINT agtAgents_FK_agentType FOREIGN KEY (agentTypeID) REFERENCES agtAgentTypes(agentTypeID)

ALTER TABLE agtResearchAgents ADD CONSTRAINT agtResearchAgents_FK_agent FOREIGN KEY (agentID) REFERENCES agtAgents(agentID)
ALTER TABLE agtResearchAgents ADD CONSTRAINT agtResearchAgents_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)

ALTER TABLE chrAncestries ADD CONSTRAINT chrAncestries_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE chrAttributes ADD CONSTRAINT chrAttributes_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE chrBloodlines ADD CONSTRAINT chrBloodlines_FK_shipType FOREIGN KEY (shipTypeID) REFERENCES invTypes(typeID)
ALTER TABLE chrBloodlines ADD CONSTRAINT chrBloodlines_FK_corporation FOREIGN KEY (corporationID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE chrBloodlines ADD CONSTRAINT chrBloodlines_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE chrFactions ADD CONSTRAINT chrFactions_FK_faction FOREIGN KEY (factionID) REFERENCES invNames(itemID)
ALTER TABLE chrFactions ADD CONSTRAINT chrFactions_FK_solarSystem FOREIGN KEY (solarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE chrFactions ADD CONSTRAINT chrFactions_FK_corporationID FOREIGN KEY (corporationID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE chrFactions ADD CONSTRAINT chrFactions_FK_militiaCorporationID FOREIGN KEY (militiaCorporationID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE chrFactions ADD CONSTRAINT chrFactions_FK_icon FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)
 
ALTER TABLE chrRaces ADD CONSTRAINT chrRaces_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE crpNPCCorporationDivisions ADD CONSTRAINT crpNPCCorporationDivisions_FK_corporation FOREIGN KEY (corporationID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporationDivisions ADD CONSTRAINT crpNPCCorporationDivisions_FK_division FOREIGN KEY (divisionID) REFERENCES crpNPCDivisions(divisionID)

ALTER TABLE crpNPCCorporationResearchFields ADD CONSTRAINT crpNPCCorporationResearchFields_FK_skill FOREIGN KEY (skillID) REFERENCES invTypes(typeID)
ALTER TABLE crpNPCCorporationResearchFields ADD CONSTRAINT crpNPCCorporationResearchFields_FK_corporatioin FOREIGN KEY (corporationID) REFERENCES crpNPCCorporations(corporationID)

ALTER TABLE dbo.crpNPCCorporationTrades ADD CONSTRAINT crpNPCCorporationTrades_FK_corporation FOREIGN KEY (corporationID) REFERENCES dbo.crpNPCCorporations(corporationID)
ALTER TABLE dbo.crpNPCCorporationTrades ADD CONSTRAINT crpNPCCorporationTrades_FK_type FOREIGN KEY (typeID) REFERENCES dbo.invTypes(typeID)

ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_corporation FOREIGN KEY (corporationID) REFERENCES invNames(itemID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_solarSystem FOREIGN KEY (solarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_investor1 FOREIGN KEY (investorID1) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_investor2 FOREIGN KEY (investorID2) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_investor3 FOREIGN KEY (investorID3) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_investor4 FOREIGN KEY (investorID4) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_friend FOREIGN KEY (friendID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_enemy FOREIGN KEY (enemyID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_faction FOREIGN KEY (factionID) REFERENCES chrFactions(factionID)
ALTER TABLE crpNPCCorporations ADD CONSTRAINT crpNPCCorporations_FK_icon FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)


ALTER TABLE dgmAttributeTypes ADD CONSTRAINT dgmAttributeTypes_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)
ALTER TABLE dgmAttributeTypes ADD CONSTRAINT dgmAttributeTypes_FK_unit FOREIGN KEY (unitID) REFERENCES eveUnits(unitID)
ALTER TABLE dgmAttributeTypes ADD CONSTRAINT dgmAttributeTypes_FK_category FOREIGN KEY (categoryID) REFERENCES dgmAttributeCategories(categoryID)

ALTER TABLE dgmTypeAttributes ADD CONSTRAINT dgmTypeAttributes_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
ALTER TABLE dgmTypeAttributes ADD CONSTRAINT dgmTypeAttributes_FK_attribute FOREIGN KEY (attributeID) REFERENCES dgmAttributeTypes(attributeID)

ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_durationAttribute FOREIGN KEY (durationAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_trackingSpeedAttribute FOREIGN KEY (trackingSpeedAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_dischargeAttribute FOREIGN KEY (dischargeAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_rangeAttribute FOREIGN KEY (rangeAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_falloffAttribute FOREIGN KEY (falloffAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_npcUsageChanceAttributeID FOREIGN KEY (npcUsageChanceAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_npcActivationChanceAttributeID FOREIGN KEY (npcActivationChanceAttributeID) REFERENCES dgmAttributeTypes(attributeID)
ALTER TABLE dgmEffects ADD CONSTRAINT dgmEffects_FK_fittingUsageChanceAttributeID FOREIGN KEY (fittingUsageChanceAttributeID) REFERENCES dgmAttributeTypes(attributeID)

ALTER TABLE dgmTypeEffects ADD CONSTRAINT dgmTypeEffects_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
ALTER TABLE dgmTypeEffects ADD CONSTRAINT dgmTypeEffects_FK_effects FOREIGN KEY (effectID) REFERENCES dgmEffects(effectID)

ALTER TABLE invUniqueNames ADD CONSTRAINT invUniqueNames_FK_item FOREIGN KEY (itemID) REFERENCES invItems(itemID)
ALTER TABLE invUniqueNames ADD CONSTRAINT invUniqueNames_FK_group FOREIGN KEY (groupID) REFERENCES invGroups(groupID)

ALTER TABLE invPositions ADD CONSTRAINT invPositions_FK_location FOREIGN KEY (itemID) REFERENCES invItems(itemID)

ALTER TABLE invNames ADD CONSTRAINT invNames_FK_item FOREIGN KEY (itemID) REFERENCES invItems(itemID)

ALTER TABLE invBlueprintTypes ADD CONSTRAINT invBlueprintTypes_FK_blueprintType FOREIGN KEY (blueprintTypeID) REFERENCES invTypes(typeID)
ALTER TABLE invBlueprintTypes ADD CONSTRAINT invBlueprintTypes_FK_parentBlueprintType FOREIGN KEY (parentBlueprintTypeID) REFERENCES invTypes(typeID)
ALTER TABLE invBlueprintTypes ADD CONSTRAINT invBlueprintTypes_FK_productType FOREIGN KEY (productTypeID) REFERENCES invTypes(typeID)

ALTER TABLE invControlTowerResources ADD CONSTRAINT invControlTowerResources_FK_faction FOREIGN KEY (factionID) REFERENCES chrFactions(factionID)
ALTER TABLE invControlTowerResources ADD CONSTRAINT invControlTowerResources_FK_resourceType FOREIGN KEY (resourceTypeID) REFERENCES invTypes(typeID)
ALTER TABLE invControlTowerResources ADD CONSTRAINT invControlTowerResources_FK_constrolTowerType FOREIGN KEY (controlTowerTypeID) REFERENCES invTypes(typeID)

ALTER TABLE invCategories ADD CONSTRAINT invCategories_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE invContrabandTypes ADD CONSTRAINT invContrabandTypes_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
ALTER TABLE invContrabandTypes ADD CONSTRAINT invContrabandTypes_FK_faction FOREIGN KEY (factionID) REFERENCES chrFactions(factionID)

ALTER TABLE invGroups ADD CONSTRAINT invGroups_FK_category FOREIGN KEY (categoryID) REFERENCES invCategories(categoryID)
ALTER TABLE invGroups ADD CONSTRAINT invGroups_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE invMarketGroups ADD CONSTRAINT invMarketGroups_FK_parentGroup FOREIGN KEY (parentGroupID) REFERENCES invMarketGroups(marketGroupID)
ALTER TABLE invMarketGroups ADD CONSTRAINT invMarketGroups_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE invMetaGroups ADD CONSTRAINT invMetaGroups_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)

ALTER TABLE invMetaTypes ADD CONSTRAINT invMetaTypes_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
ALTER TABLE invMetaTypes ADD CONSTRAINT invMetaTypes_FK_parentType FOREIGN KEY (parentTypeID) REFERENCES invTypes(typeID)
ALTER TABLE invMetaTypes ADD CONSTRAINT invMetaTypes_FK_metaGroup FOREIGN KEY (metaGroupID) REFERENCES invMetaGroups(metaGroupID)

ALTER TABLE invTypeReactions ADD CONSTRAINT invTypeReactions_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)

ALTER TABLE invTypes ADD CONSTRAINT invTypes_FK_group FOREIGN KEY (groupID) REFERENCES invGroups(groupID)
ALTER TABLE invTypes ADD CONSTRAINT invTypes_FK_icon FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)
ALTER TABLE invTypes ADD CONSTRAINT invTypes_FK_graphic FOREIGN KEY (graphicID) REFERENCES eveGraphics(graphicID)
ALTER TABLE invTypes ADD CONSTRAINT invTypes_FK_race FOREIGN KEY (raceID) REFERENCES chrRaces(raceID)
ALTER TABLE invTypes ADD CONSTRAINT invTypes_FK_marketGroup FOREIGN KEY (marketGroupID) REFERENCES invMarketGroups(marketGroupID)

ALTER TABLE mapCelestialStatistics ADD CONSTRAINT mapCelestialStatistics_celestial FOREIGN KEY (celestialID) REFERENCES invPositions(itemID)

ALTER TABLE mapConstellationJumps ADD CONSTRAINT mapConstellationJumps_FK_toConstellation FOREIGN KEY (toConstellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE mapConstellationJumps ADD CONSTRAINT mapConstellationJumps_FK_fromConstellation FOREIGN KEY (fromConstellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE mapConstellationJumps ADD CONSTRAINT mapConstellationJumps_FK_toRegion FOREIGN KEY (toRegionID) REFERENCES mapRegions(regionID)
ALTER TABLE mapConstellationJumps ADD CONSTRAINT mapConstellationJumps_FK_fromRegion FOREIGN KEY (fromRegionID) REFERENCES mapRegions(regionID)

ALTER TABLE mapConstellations ADD CONSTRAINT mapConstellations_FK_constellation FOREIGN KEY (constellationID) REFERENCES invPositions(itemID)
ALTER TABLE mapConstellations ADD CONSTRAINT mapConstellations_FK_region FOREIGN KEY (regionID) REFERENCES mapRegions(regionID)
ALTER TABLE mapConstellations ADD CONSTRAINT mapConstellations_FK_faction FOREIGN KEY (factionID) REFERENCES chrFactions(factionID)

ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_item FOREIGN KEY (itemID) REFERENCES invPositions(itemID)
ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_solarSystem FOREIGN KEY (solarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_constellation FOREIGN KEY (constellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_region FOREIGN KEY (regionID) REFERENCES mapRegions(regionID)
ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_group FOREIGN KEY (groupID) REFERENCES invGroups(groupID)
ALTER TABLE mapDenormalize ADD CONSTRAINT mapDenormalize_FK_orbit FOREIGN KEY (orbitID) REFERENCES invPositions(itemID)

ALTER TABLE mapJumps ADD CONSTRAINT mapJumps_FK_celestial FOREIGN KEY (celestialID) REFERENCES invPositions(itemID)
ALTER TABLE mapJumps ADD CONSTRAINT mapJumps_FK_stargate FOREIGN KEY (stargateID) REFERENCES invPositions(itemID)

ALTER TABLE mapLandmarks ADD CONSTRAINT mapLandmarks_FK_graphic FOREIGN KEY (iconID) REFERENCES eveIcons(iconID)
ALTER TABLE mapLandmarks ADD CONSTRAINT mapLandmarks_FK_location FOREIGN KEY (locationID) REFERENCES mapSolarSystems(solarSystemID)

ALTER TABLE mapRegionJumps ADD CONSTRAINT mapRegionJumps_FK_toRegion FOREIGN KEY (toRegionID) REFERENCES mapRegions(regionID)
ALTER TABLE mapRegionJumps ADD CONSTRAINT mapRegionJumps_FK_fromRegion FOREIGN KEY (fromRegionID) REFERENCES mapRegions(regionID)

ALTER TABLE mapRegions ADD CONSTRAINT mapRegions_FK_region FOREIGN KEY (regionID) REFERENCES invPositions(itemID)
ALTER TABLE mapRegions ADD CONSTRAINT mapRegions_FK_faction FOREIGN KEY (factionID) REFERENCES chrFactions(factionID)

ALTER TABLE mapSolarSystemJumps ADD CONSTRAINT mapSolarSystemJumps_FK_toSolarSystem FOREIGN KEY (toSolarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE mapSolarSystemJumps ADD CONSTRAINT mapSolarSystemJumps_FK_fromSolarSystem FOREIGN KEY (fromSolarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE mapSolarSystemJumps ADD CONSTRAINT mapSolarSystemJumps_FK_toConstellation FOREIGN KEY (toConstellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE mapSolarSystemJumps ADD CONSTRAINT mapSolarSystemJumps_FK_fromConstellation FOREIGN KEY (fromConstellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE mapSolarSystemJumps ADD CONSTRAINT mapSolarSystemJumps_FK_toRegion FOREIGN KEY (toRegionID) REFERENCES mapRegions(regionID)
ALTER TABLE mapSolarSystemJumps ADD CONSTRAINT mapSolarSystemJumps_FK_fromRegion FOREIGN KEY (fromRegionID) REFERENCES mapRegions(regionID)

ALTER TABLE mapSolarSystems ADD CONSTRAINT mapSolarSystems_FK_system FOREIGN KEY (solarSystemID) REFERENCES invPositions(itemID)
ALTER TABLE mapSolarSystems ADD CONSTRAINT mapSolarSystems_FK_constellation FOREIGN KEY (constellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE mapSolarSystems ADD CONSTRAINT mapSolarSystems_FK_regionID FOREIGN KEY (regionID) REFERENCES mapRegions(regionID)
ALTER TABLE mapSolarSystems ADD CONSTRAINT mapSolarSystems_FK_faction FOREIGN KEY (factionID) REFERENCES chrFactions(factionID)
ALTER TABLE mapSolarSystems ADD CONSTRAINT mapSolarSystems_FK_sunType FOREIGN KEY (sunTypeID) REFERENCES invTypes(typeID)

ALTER TABLE ramAssemblyLines ADD CONSTRAINT ramAssemblyLines_FK_assemblyLineType FOREIGN KEY (assemblyLineTypeID) REFERENCES ramAssemblyLineTypes(assemblyLineTypeID)
ALTER TABLE ramAssemblyLines ADD CONSTRAINT ramAssemblyLines_FK_container FOREIGN KEY (containerID) REFERENCES staStations(stationID)
ALTER TABLE ramAssemblyLines ADD CONSTRAINT ramAssemblyLines_FK_owner FOREIGN KEY (ownerID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE ramAssemblyLines ADD CONSTRAINT ramAssemblyLines_FK_activity FOREIGN KEY (activityID) REFERENCES ramActivities(activityID)

ALTER TABLE ramAssemblyLineStations ADD CONSTRAINT ramAssemblyLineStations_FK_station FOREIGN KEY (stationID) REFERENCES staStations(stationID)
ALTER TABLE ramAssemblyLineStations ADD CONSTRAINT ramAssemblyLineStations_FK_assemblyLineType FOREIGN KEY (assemblyLineTypeID) REFERENCES ramAssemblyLineTypes(assemblyLineTypeID)
ALTER TABLE ramAssemblyLineStations ADD CONSTRAINT ramAssemblyLineStations_FK_owner FOREIGN KEY (ownerID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE ramAssemblyLineStations ADD CONSTRAINT ramAssemblyLineStations_FK_stationType FOREIGN KEY (stationTypeID) REFERENCES staStationTypes(stationTypeID)
ALTER TABLE ramAssemblyLineStations ADD CONSTRAINT ramAssemblyLineStations_FK_solarSystem FOREIGN KEY (solarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE ramAssemblyLineStations ADD CONSTRAINT ramAssemblyLineStations_FK_region FOREIGN KEY (regionID) REFERENCES mapRegions(regionID)

ALTER TABLE ramAssemblyLineTypeDetailPerCategory ADD CONSTRAINT ramAssemblyLineTypeDetailPerCategory_FK_assemblyLineType FOREIGN KEY (assemblyLineTypeID) REFERENCES ramAssemblyLineTypes(assemblyLineTypeID)
ALTER TABLE ramAssemblyLineTypeDetailPerCategory ADD CONSTRAINT ramAssemblyLineTypeDetailPerCategory_FK_category FOREIGN KEY (categoryID) REFERENCES invCategories(categoryID)

ALTER TABLE ramAssemblyLineTypeDetailPerGroup ADD CONSTRAINT ramAssemblyLineTypeDetailPerGroup_FK_assemblyLineType FOREIGN KEY (assemblyLineTypeID) REFERENCES ramAssemblyLineTypes(assemblyLineTypeID)
ALTER TABLE ramAssemblyLineTypeDetailPerGroup ADD CONSTRAINT ramAssemblyLineTypeDetailPerGroup_FK_group FOREIGN KEY (groupID) REFERENCES invGroups(groupID)

ALTER TABLE ramAssemblyLineTypes ADD CONSTRAINT ramAssemblyLineTypes_FK_activity FOREIGN KEY (activityID) REFERENCES ramActivities(activityID)

ALTER TABLE staOperations ADD CONSTRAINT staOperations_FK_activity FOREIGN KEY (activityID) REFERENCES crpActivities(activityID)
ALTER TABLE staOperations ADD CONSTRAINT staOperations_FK_caldariStationType FOREIGN KEY (caldariStationTypeID) REFERENCES invTypes(typeID)
ALTER TABLE staOperations ADD CONSTRAINT staOperations_FK_minmatarStationType FOREIGN KEY (minmatarStationTypeID) REFERENCES invTypes(typeID)
ALTER TABLE staOperations ADD CONSTRAINT staOperations_FK_amarrStationType FOREIGN KEY (amarrStationTypeID) REFERENCES invTypes(typeID)
ALTER TABLE staOperations ADD CONSTRAINT staOperations_FK_gallenteStationType FOREIGN KEY (gallenteStationTypeID) REFERENCES invTypes(typeID)
ALTER TABLE staOperations ADD CONSTRAINT staOperations_FK_joveStationType FOREIGN KEY (joveStationTypeID) REFERENCES invTypes(typeID)

ALTER TABLE staOperationServices ADD CONSTRAINT staOperationServices_FK_operation FOREIGN KEY (operationID) REFERENCES staOperations(operationID)
ALTER TABLE staOperationServices ADD CONSTRAINT staOperationServices_FK_service FOREIGN KEY (serviceID) REFERENCES staServices(serviceID)

ALTER TABLE staStationTypes ADD CONSTRAINT staStationTypes_FK_stationType FOREIGN KEY (stationTypeID) REFERENCES invTypes(typeID)

ALTER TABLE staStations ADD CONSTRAINT staStations_FK_station FOREIGN KEY (stationID) REFERENCES invPositions(itemID)
ALTER TABLE staStations ADD CONSTRAINT staStations_FK_operation FOREIGN KEY (operationID) REFERENCES staOperations(operationID)
ALTER TABLE staStations ADD CONSTRAINT staStations_FK_type FOREIGN KEY (stationTypeID) REFERENCES staTypes(stationTypeID)
ALTER TABLE staStations ADD CONSTRAINT staStations_FK_corporation FOREIGN KEY (corporationID) REFERENCES crpNPCCorporations(corporationID)
ALTER TABLE staStations ADD CONSTRAINT staStations_FK_solarSystem FOREIGN KEY (solarSystemID) REFERENCES mapSolarSystems(solarSystemID)
ALTER TABLE staStations ADD CONSTRAINT staStation_FK_constellation FOREIGN KEY (constellationID) REFERENCES mapConstellations(constellationID)
ALTER TABLE staStations ADD CONSTRAINT staStationd_FK_region FOREIGN KEY (regionID) REFERENCES mapRegions(regionID)

ALTER TABLE dbo.ramTypeRequirements ADD CONSTRAINT ramTypeRequirements_FK_activity FOREIGN KEY (activityID) REFERENCES ramActivities(activityID)
ALTER TABLE dbo.ramTypeRequirements ADD CONSTRAINT ramTypeRequirements_FK_requiredType FOREIGN KEY (requiredTypeID) REFERENCES invTypes(typeID)

ALTER TABLE dbo.invTypeMaterials ADD CONSTRAINT invTypeMaterials_FK_type FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
ALTER TABLE dbo.invTypeMaterials ADD CONSTRAINT invTypeMaterials_FK_materialType FOREIGN KEY (typeID) REFERENCES invTypes(typeID)
*/