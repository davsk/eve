--EveStaticUpdate.sql

-- Schema: dbo

DROP SCHEMA IF EXISTS dbo CASCADE;

CREATE SCHEMA dbo;

GRANT ALL ON SCHEMA dbo TO postgres;
GRANT ALL ON SCHEMA dbo TO public;
COMMENT ON SCHEMA dbo
  IS 'database output from Eve Online';

