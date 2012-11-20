USE [eveonline]
GO

/****** Object:  Table [dbo].[agtAgents]    Script Date: 11/19/2012 16:05:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[agtAgents](
	[agentID] [int] NOT NULL,
	[divisionID] [tinyint] NULL,
	[corporationID] [int] NULL,
	[locationID] [int] NULL,
	[level] [tinyint] NULL,
	[quality] [smallint] NULL,
	[agentTypeID] [int] NULL,
	[isLocator] [bit] NULL,
 CONSTRAINT [agtAgents_PK] PRIMARY KEY CLUSTERED 
(
	[agentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[agtResearchAgents]    Script Date: 11/19/2012 16:10:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[agtResearchAgents](
	[agentID] [int] NOT NULL,
	[typeID] [int] NOT NULL,
 CONSTRAINT [agtResearchAgents_PK] PRIMARY KEY CLUSTERED 
(
	[agentID] ASC,
	[typeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
USE [eveonline]
GO

/****** Object:  Table [dbo].[crpNPCCorporationDivisions]    Script Date: 11/19/2012 16:10:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[crpNPCCorporationDivisions](
	[corporationID] [int] NOT NULL,
	[divisionID] [tinyint] NOT NULL,
	[size] [tinyint] NULL,
 CONSTRAINT [crpNPCCorporationDivisions_PK] PRIMARY KEY CLUSTERED 
(
	[corporationID] ASC,
	[divisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[crpNPCCorporations]    Script Date: 11/19/2012 16:11:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[crpNPCCorporations](
	[corporationID] [int] NOT NULL,
	[size] [char](1) NULL,
	[extent] [char](1) NULL,
	[solarSystemID] [int] NULL,
	[investorID1] [int] NULL,
	[investorShares1] [tinyint] NULL,
	[investorID2] [int] NULL,
	[investorShares2] [tinyint] NULL,
	[investorID3] [int] NULL,
	[investorShares3] [tinyint] NULL,
	[investorID4] [int] NULL,
	[investorShares4] [tinyint] NULL,
	[friendID] [int] NULL,
	[enemyID] [int] NULL,
	[publicShares] [bigint] NULL,
	[initialPrice] [int] NULL,
	[minSecurity] [float] NULL,
	[scattered] [bit] NULL,
	[fringe] [tinyint] NULL,
	[corridor] [tinyint] NULL,
	[hub] [tinyint] NULL,
	[border] [tinyint] NULL,
	[factionID] [int] NULL,
	[sizeFactor] [float] NULL,
	[stationCount] [smallint] NULL,
	[stationSystemCount] [smallint] NULL,
	[description] [nvarchar](4000) NULL,
	[iconID] [int] NULL,
 CONSTRAINT [crpNPCCorporations_PK] PRIMARY KEY CLUSTERED 
(
	[corporationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[translationTables]    Script Date: 11/19/2012 16:12:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[translationTables](
	[sourceTable] [nvarchar](200) NOT NULL,
	[destinationTable] [nvarchar](200) NULL,
	[translatedKey] [nvarchar](200) NOT NULL,
	[tcGroupID] [int] NULL,
	[tcID] [int] NULL,
 CONSTRAINT [translationTables_PK] PRIMARY KEY CLUSTERED 
(
	[sourceTable] ASC,
	[translatedKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[eveIcons]    Script Date: 11/19/2012 16:13:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[eveIcons](
	[iconID] [int] NOT NULL,
	[iconFile] [varchar](500) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
 CONSTRAINT [eveIcons_PK] PRIMARY KEY CLUSTERED 
(
	[iconID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[eveIcons] ADD  DEFAULT ('') FOR [iconFile]
GO

ALTER TABLE [dbo].[eveIcons] ADD  DEFAULT ('') FOR [description]
GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invItems]    Script Date: 11/19/2012 16:14:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invItems](
	[itemID] [bigint] NOT NULL,
	[typeID] [int] NOT NULL,
	[ownerID] [int] NOT NULL,
	[locationID] [bigint] NOT NULL,
	[flagID] [smallint] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [invItems_PK] PRIMARY KEY CLUSTERED 
(
	[itemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invUniqueNames]    Script Date: 11/19/2012 16:14:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invUniqueNames](
	[itemID] [int] NOT NULL,
	[itemName] [nvarchar](200) NOT NULL,
	[groupID] [int] NULL,
 CONSTRAINT [invUniqueNames_PK] PRIMARY KEY CLUSTERED 
(
	[itemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invNames]    Script Date: 11/19/2012 16:15:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invNames](
	[itemID] [bigint] NOT NULL,
	[itemName] [nvarchar](200) NOT NULL,
 CONSTRAINT [invNames_PK] PRIMARY KEY CLUSTERED 
(
	[itemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invPositions]    Script Date: 11/19/2012 16:15:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invPositions](
	[itemID] [bigint] NOT NULL,
	[x] [float] NOT NULL,
	[y] [float] NOT NULL,
	[z] [float] NOT NULL,
	[yaw] [real] NULL,
	[pitch] [real] NULL,
	[roll] [real] NULL,
 CONSTRAINT [invPositions_PK] PRIMARY KEY CLUSTERED 
(
	[itemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[invPositions] ADD  DEFAULT ((0.0)) FOR [x]
GO

ALTER TABLE [dbo].[invPositions] ADD  DEFAULT ((0.0)) FOR [y]
GO

ALTER TABLE [dbo].[invPositions] ADD  DEFAULT ((0.0)) FOR [z]
GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invCategories]    Script Date: 11/19/2012 16:16:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invCategories](
	[categoryID] [int] NOT NULL,
	[categoryName] [nvarchar](100) NULL,
	[description] [nvarchar](3000) NULL,
	[iconID] [int] NULL,
	[published] [bit] NULL,
 CONSTRAINT [invCategories_PK] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invContrabandTypes]    Script Date: 11/19/2012 16:17:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invContrabandTypes](
	[factionID] [int] NOT NULL,
	[typeID] [int] NOT NULL,
	[standingLoss] [float] NULL,
	[confiscateMinSec] [float] NULL,
	[fineByValue] [float] NULL,
	[attackMinSec] [float] NULL,
 CONSTRAINT [invContrabandTypes_PK] PRIMARY KEY CLUSTERED 
(
	[factionID] ASC,
	[typeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invGroups]    Script Date: 11/19/2012 16:17:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invGroups](
	[groupID] [int] NOT NULL,
	[categoryID] [int] NULL,
	[groupName] [nvarchar](100) NULL,
	[description] [nvarchar](3000) NULL,
	[iconID] [int] NULL,
	[useBasePrice] [bit] NULL,
	[allowManufacture] [bit] NULL,
	[allowRecycler] [bit] NULL,
	[anchored] [bit] NULL,
	[anchorable] [bit] NULL,
	[fittableNonSingleton] [bit] NULL,
	[published] [bit] NULL,
 CONSTRAINT [invGroups_PK] PRIMARY KEY CLUSTERED 
(
	[groupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[invTypes]    Script Date: 11/19/2012 16:18:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[invTypes](
	[typeID] [int] NOT NULL,
	[groupID] [int] NULL,
	[typeName] [nvarchar](100) NULL,
	[description] [nvarchar](3000) NULL,
	[mass] [float] NULL,
	[volume] [float] NULL,
	[capacity] [float] NULL,
	[portionSize] [int] NULL,
	[raceID] [tinyint] NULL,
	[basePrice] [money] NULL,
	[published] [bit] NULL,
	[marketGroupID] [int] NULL,
	[chanceOfDuplicating] [float] NULL,
	[iconID] [int] NULL,
 CONSTRAINT [invTypes_PK] PRIMARY KEY CLUSTERED 
(
	[typeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapConstellationJumps]    Script Date: 11/19/2012 16:18:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mapConstellationJumps](
	[fromRegionID] [int] NULL,
	[fromConstellationID] [int] NOT NULL,
	[toConstellationID] [int] NOT NULL,
	[toRegionID] [int] NULL,
 CONSTRAINT [mapConstellationJumps_PK] PRIMARY KEY CLUSTERED 
(
	[fromConstellationID] ASC,
	[toConstellationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapConstellations]    Script Date: 11/19/2012 16:19:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mapConstellations](
	[regionID] [int] NULL,
	[constellationID] [int] NOT NULL,
	[constellationName] [nvarchar](100) NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[xMin] [float] NULL,
	[xMax] [float] NULL,
	[yMin] [float] NULL,
	[yMax] [float] NULL,
	[zMin] [float] NULL,
	[zMax] [float] NULL,
	[factionID] [int] NULL,
	[radius] [float] NULL,
 CONSTRAINT [mapConstellations_PK] PRIMARY KEY CLUSTERED 
(
	[constellationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapLandmarks]    Script Date: 11/19/2012 16:28:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[mapLandmarks](
	[landmarkID] [smallint] NOT NULL,
	[landmarkName] [varchar](100) NULL,
	[description] [varchar](7000) NULL,
	[locationID] [int] NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[radius] [float] NULL,
	[iconID] [int] NULL,
	[importance] [tinyint] NULL,
 CONSTRAINT [mapLandmarks_PK] PRIMARY KEY CLUSTERED 
(
	[landmarkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapRegions]    Script Date: 11/19/2012 16:30:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mapRegions](
	[regionID] [int] NOT NULL,
	[regionName] [nvarchar](100) NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[xMin] [float] NULL,
	[xMax] [float] NULL,
	[yMin] [float] NULL,
	[yMax] [float] NULL,
	[zMin] [float] NULL,
	[zMax] [float] NULL,
	[factionID] [int] NULL,
	[radius] [float] NULL,
 CONSTRAINT [mapRegions_PK] PRIMARY KEY CLUSTERED 
(
	[regionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapSolarSystemJumps]    Script Date: 11/19/2012 16:34:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mapSolarSystemJumps](
	[fromRegionID] [int] NULL,
	[fromConstellationID] [int] NULL,
	[fromSolarSystemID] [int] NOT NULL,
	[toSolarSystemID] [int] NOT NULL,
	[toConstellationID] [int] NULL,
	[toRegionID] [int] NULL,
 CONSTRAINT [mapSolarSystemJumps_PK] PRIMARY KEY CLUSTERED 
(
	[fromSolarSystemID] ASC,
	[toSolarSystemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapSolarSystems]    Script Date: 11/19/2012 16:35:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[mapSolarSystems](
	[regionID] [int] NULL,
	[constellationID] [int] NULL,
	[solarSystemID] [int] NOT NULL,
	[solarSystemName] [nvarchar](100) NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[xMin] [float] NULL,
	[xMax] [float] NULL,
	[yMin] [float] NULL,
	[yMax] [float] NULL,
	[zMin] [float] NULL,
	[zMax] [float] NULL,
	[luminosity] [float] NULL,
	[border] [bit] NULL,
	[fringe] [bit] NULL,
	[corridor] [bit] NULL,
	[hub] [bit] NULL,
	[international] [bit] NULL,
	[regional] [bit] NULL,
	[constellation] [bit] NULL,
	[security] [float] NULL,
	[factionID] [int] NULL,
	[radius] [float] NULL,
	[sunTypeID] [int] NULL,
	[securityClass] [varchar](2) NULL,
 CONSTRAINT [mapSolarSystems_PK] PRIMARY KEY CLUSTERED 
(
	[solarSystemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[mapUniverse]    Script Date: 11/19/2012 16:36:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[mapUniverse](
	[universeID] [int] NOT NULL,
	[universeName] [varchar](100) NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[xMin] [float] NULL,
	[xMax] [float] NULL,
	[yMin] [float] NULL,
	[yMax] [float] NULL,
	[zMin] [float] NULL,
	[zMax] [float] NULL,
	[radius] [float] NULL,
 CONSTRAINT [mapUniverse_PK] PRIMARY KEY CLUSTERED 
(
	[universeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[ramAssemblyLines]    Script Date: 11/19/2012 16:36:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ramAssemblyLines](
	[assemblyLineID] [int] NOT NULL,
	[assemblyLineTypeID] [tinyint] NULL,
	[containerID] [int] NULL,
	[nextFreeTime] [smalldatetime] NULL,
	[UIGroupingID] [tinyint] NULL,
	[costInstall] [float] NULL,
	[costPerHour] [float] NULL,
	[restrictionMask] [tinyint] NULL,
	[discountPerGoodStandingPoint] [float] NULL,
	[surchargePerBadStandingPoint] [float] NULL,
	[minimumStanding] [float] NULL,
	[minimumCharSecurity] [float] NULL,
	[minimumCorpSecurity] [float] NULL,
	[maximumCharSecurity] [float] NULL,
	[maximumCorpSecurity] [float] NULL,
	[ownerID] [int] NULL,
	[activityID] [tinyint] NULL,
 CONSTRAINT [ramAssemblyLines_PK] PRIMARY KEY CLUSTERED 
(
	[assemblyLineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[ramAssemblyLineStations]    Script Date: 11/19/2012 16:37:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ramAssemblyLineStations](
	[stationID] [int] NOT NULL,
	[assemblyLineTypeID] [tinyint] NOT NULL,
	[quantity] [tinyint] NULL,
	[stationTypeID] [int] NULL,
	[ownerID] [int] NULL,
	[solarSystemID] [int] NULL,
	[regionID] [int] NULL,
 CONSTRAINT [ramAssemblyLineStations_PK] PRIMARY KEY CLUSTERED 
(
	[stationID] ASC,
	[assemblyLineTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[staStations]    Script Date: 11/19/2012 16:38:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[staStations](
	[stationID] [int] NOT NULL,
	[security] [smallint] NULL,
	[dockingCostPerVolume] [float] NULL,
	[maxShipVolumeDockable] [float] NULL,
	[officeRentalCost] [int] NULL,
	[operationID] [tinyint] NULL,
	[stationTypeID] [int] NULL,
	[corporationID] [int] NULL,
	[solarSystemID] [int] NULL,
	[constellationID] [int] NULL,
	[regionID] [int] NULL,
	[stationName] [nvarchar](100) NULL,
	[x] [float] NULL,
	[y] [float] NULL,
	[z] [float] NULL,
	[reprocessingEfficiency] [float] NULL,
	[reprocessingStationsTake] [float] NULL,
	[reprocessingHangarFlag] [tinyint] NULL,
 CONSTRAINT [staStations_PK] PRIMARY KEY CLUSTERED 
(
	[stationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[crtCertificates]    Script Date: 11/19/2012 16:38:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[crtCertificates](
	[certificateID] [int] NOT NULL,
	[categoryID] [tinyint] NULL,
	[classID] [int] NULL,
	[grade] [tinyint] NULL,
	[corpID] [int] NULL,
	[iconID] [int] NULL,
	[description] [nvarchar](500) NULL,
 CONSTRAINT [crtCertificates_PK] PRIMARY KEY CLUSTERED 
(
	[certificateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[crtRelationships]    Script Date: 11/19/2012 16:39:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[crtRelationships](
	[relationshipID] [int] NOT NULL,
	[parentID] [int] NULL,
	[parentTypeID] [int] NULL,
	[parentLevel] [tinyint] NULL,
	[childID] [int] NULL,
 CONSTRAINT [crtRelationships_relationship] PRIMARY KEY CLUSTERED 
(
	[relationshipID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [eveonline]
GO

/****** Object:  Table [dbo].[crtRecommendations]    Script Date: 11/19/2012 16:39:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[crtRecommendations](
	[recommendationID] [int] NOT NULL,
	[shipTypeID] [int] NULL,
	[certificateID] [int] NULL,
	[recommendationLevel] [tinyint] NOT NULL,
 CONSTRAINT [crtRecommendations_PK] PRIMARY KEY CLUSTERED 
(
	[recommendationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[crtRecommendations] ADD  DEFAULT ((0)) FOR [recommendationLevel]
GO


