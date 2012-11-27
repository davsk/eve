#! /usr/bin/env bash

#EveStaticUpdate.sh

echo "\i EveStaticUpdate.sql" >psql.inp
echo "\i ebs_DATADUMPpg.sql" >>psql.inp

for file in ../csv/*
do
	filename=$(basename "${file}")
	extension="${filename##*.}"
	filename="${filename%.*}"

	# only process csv files
	if [ "${extension}" == "csv" ]
	then	
		# skip list of tables
		if [ "${filename}" != "TABLE_NAME" ]	
		then
			#  convert to UTF-8
			echo "iconv processing " ${file}
			iconv -f UTF16LE -t UTF-8 -o tmp/${filename}.csv ${file}

			# fix use of reserved word in headers
			if [[ ( "${filename}" == "mapRegions" ) || \
				( "${filename}" == "mapConstellations" ) || \
				( "${filename}" == "mapSolarSystems" ) || \
				( "${filename}" == "mapUniverse") ]]
			then
				echo "sed processing " ${file}
				sed -i "s/xMin/x_Min/g;s/yMin/y_Min/g;s/zMin/z_Min/g;s/xMax/x_Max/g;s/yMax/y_Max/g;s/zMax/z_Max/g" tmp/${filename}.csv ]
			fi		
			
			# create import command
			echo "\copy dbo.${filename} from tmp/${filename}.csv with delimiter ',' null as '""' csv header" >>psql.inp
		fi
	fi
done

# sed -i "s/ if the end of line is not a quote, add a quote, if line is only a quote, delete the line" tmp/trnTranslations.csv
echo "\q" >>psql.inp
echo "next command $ psql eve <psql.inp 2>psql.log"
