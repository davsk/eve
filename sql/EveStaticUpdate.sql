--EveStaticUpdate.sql

-- Schema: dbo

DROP SCHEMA IF EXISTS dbo CASCADE;

CREATE SCHEMA dbo;

GRANT ALL ON SCHEMA dbo TO postgres;
GRANT ALL ON SCHEMA dbo TO goeve;
GRANT ALL ON SCHEMA dbo TO public;

COMMENT ON SCHEMA dbo
  IS 'database output from Eve Online';

CREATE TABLE dbo.eveGraphics(
	graphicID int NOT NULL,
	graphicFile text NOT NULL DEFAULT '',
	description text NOT NULL DEFAULT '',
	obsolete bit NOT NULL DEFAULT '0',
	graphicType text NULL,
	collidable bit NULL,
	explosionID int NULL,
	directoryID int NULL,
	graphicName text NOT NULL DEFAULT '',
 CONSTRAINT eveGraphics_PK PRIMARY KEY (graphicID)
 );

CREATE TABLE dbo.translationTables(
	sourceTable			text,
	destinationTable	text,
	translatedKey 		text,
	tcGroupID			int,
	tcID 				int,
CONSTRAINT translationTables_PK PRIMARY KEY (sourceTable, destinationTable, translatedKey)
);