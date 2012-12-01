#! /usr/bin/env bash

#EveStaticUpdate.sh

echo "\i EveStaticUpdate.sql" >psql.inp
echo "\i ebs_DATADUMPpg.sql" >>psql.inp

mkdir tmp

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
			dos2unix -m tmp/${filename}.csv

			# define nulls
			sed -i "s/,\"\"/,null/g" tmp/${filename}.csv

			# fix use of reserved word in headers
			if [[ ( "${filename}" == "mapRegions" ) || \
				( "${filename}" == "mapConstellations" ) || \
				( "${filename}" == "mapSolarSystems" ) || \
				( "${filename}" == "mapUniverse") ]]
			then
				echo "sed processing " ${filename}
				sed -i "s/xMin/x_Min/g;s/yMin/y_Min/g;s/zMin/z_Min/g;s/xMax/x_Max/g;s/yMax/y_Max/g;s/zMax/z_Max/g" tmp/${filename}.csv
			elif [ "${filename}" == "invNames" ]
			then
				echo "sed processing " ${filename}
				sed -i "s/,null/,\" \"/g" tmp/${filename}.csv
			elif [ "${filename}" == "invTypes" ]
			then
				echo "sed processing " ${filename}
				sed -i "s/\"borrowed\"/'borrowed'/g;s/,nullA/,\"A/g;s/.\" /. /g" tmp/${filename}.csv
			elif [ "${filename}" == "mapCelestialStatistics" ]
			then
				echo "Test"
				#sed -i "s/4.9410499999999997E-52/0/g;s/.\" /. /g" tmp/${filename}.csv
			fi		
			
			# create import command
			# null as '' 
			echo "\echo Loading ${filename}" >>psql.inp 
			echo "\copy dbo.${filename} from tmp/${filename}.csv with delimiter ',' null as 'null' csv header" >>psql.inp
		fi
	fi
done

gawk 'BEGIN{RS="\n\"\n";ORS="\"\n";}$0' tmp/trnTranslations.csv >tmp/trnTranslations.tmp
rm tmp/trnTranslations.csv
mv tmp/trnTranslations.tmp tmp/trnTranslations.csv

echo "\q" >>psql.inp
echo "next command $ psql eve <psql.inp 2>psql.log"
