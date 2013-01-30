-- createApi.sql

CREATE SCHEMA api;

GRANT ALL ON SCHEMA api TO goeve;
GRANT ALL ON SCHEMA api TO public;

CREATE TABLE api.keys
(
  account text NOT NULL,
  keyId integer NOT NULL, -- The ID of the Customizable API Key for authentication
  vCode text, -- The user defined or CCP generated Verification Code for the Customizable API Key
  accessMask integer, -- The bitwise number of the calls the API key can query
  type text, -- The access level of the API key (ex. Account, Character, Corporation)
  expires date, -- The date the API key expires. This value will be empty if the key is not set to expire.
  status text,
  CONSTRAINT ApiKeys_pk PRIMARY KEY (account , keyId )
)
WITH (
  OIDS=FALSE
);

COMMENT ON COLUMN api.keys.keyId IS 'The ID of the Customizable API Key for authentication';
COMMENT ON COLUMN api.keys.vCode IS 'The user defined or CCP generated Verification Code for the Customizable API Key';
COMMENT ON COLUMN api.keys.accessMask IS 'The bitwise number of the calls the API key can query';
COMMENT ON COLUMN api.keys.type IS 'The access level of the API key (ex. Account, Character, Corporation)';
COMMENT ON COLUMN api.keys.expires IS 'The date the API key expires. This value will be empty if the key is not set to expire.';


CREATE TABLE api.corp 
(
	corpId integer NOT NULL,
	corpName text NOT NULL,
	keyId integer NOT NULL,
	CONSTRAINT corpId_pk PRIMARY KEY (corpId)
);


CREATE VIEW api.corpContext AS 
SELECT corp.corpId,
	corp.corpName,
	corp.keyId,
	keys.vCode,
	keys.accessMask,
	keys.expires,
	keys.status
FROM api.corp
LEFT JOIN api.keys ON corp.keyId = keys.keyId;


CREATE TABLE api.chars 
(
	charId integer NOT NULL,
	charName text NOT NULL,
	keyId integer NOT NULL,
	CONSTRAINT chars_pk PRIMARY KEY (charId)
);


CREATE VIEW api.charContext AS 
SELECT chars.charId,
	chars.charName,
	chars.keyId,
	keys.vCode,
	keys.accessMask,
	keys.expires,
	keys.status
FROM api.chars
LEFT JOIN api.keys ON chars.keyId = keys.keyId;


CREATE TABLE api.cache
(
	id integer,
	type integer,
	apiId integer,
	ext text,
	cacheUntil date,
	xml text,
	CONSTRAINT cache_pk PRIMARY KEY (id, type, apiId, ext)
);