#! /usr/bin/env bash

#EveStaticUpdate.sh

echo "\i EveStaticUpdate.sql" >test.inp
echo "\i ebs_DATADUMPpg.sql" >>test.inp

for file in ../csv/*
do
	filename=$(basename "${file}")
	extension="${filename##*.}"
	filename="${filename%.*}"

	if [ "${extension}" == "csv" ]
	then	
		if [ "${filename}" != "TABLE_NAME" ]	
		then		
			echo "\copy dbo.${filename} from ${file} with delimiter ',' null as '""' csv header" >>test.inp
		fi
	fi
done

echo "\q" >>test.inp
