--EveStaticCopy.sql

--Run EveStaticUpdate first to clean the dbo schema
--Run ebs_DATADUMPpg to create the tables
--Run this file third

COPY dbo.agtAgentTypes FROM '/home/david/EveExport/EveExport/agtAgentTypes.csv' DELIMITERS ',' CSV;

\copy dbo.agtAgentTypes from /home/david/EveExport/EveExport/agtAgentTypes.csv with delimiter ',' csv header
\copy dbo.agtAgents from /home/david/EveExport/EveExport/agtAgents.csv with delimiter ',' csv header
\copy dbo.agtAgentTypes from /home/david/EveExport/EveExport/agtAgentTypes.csv with delimiter ',' csv header
