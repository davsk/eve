--EveStaticUpdate.sql

-- Schema: dbo

DROP SCHEMA dbo;

CREATE SCHEMA dbo
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA dbo TO postgres;
GRANT ALL ON SCHEMA dbo TO public;
COMMENT ON SCHEMA dbo
  IS 'database output from Eve Online';

