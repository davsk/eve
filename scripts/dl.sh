#! /usr/bin/env bash

function load {
	gzip -d tmp/*.gz
	ls tmp/*.txt | awk '{print "./convert.sh " $1 " > " $1 ".new; mv " $1 ".new " $1 ";psql eve -f " $1}' | sh

	# debug
	#ls tmp/*.txt | awk '{print "./convert.sh " $1 " > " $1 ".new"}' | sh

	rm tmp/*.txt
}

mkdir -p tmp

# THESE ARE UPDATED ONLY WHEN THE DATA CHANGES, YOU DON'T NEED THEM EVERY NIGHT.
wget -P tmp http://eve-marketdata.com/developers/mysql.txt

# fix a goof in the file
sed -i 's/_system_id/_solarsystem_id/g' tmp/mysql.txt

load

wget -P tmp http://eve-marketdata.com/developers/mysql_eve_inv_marketgroups.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_eve_map_regions.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_eve_map_solarsystem_jumps.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_eve_map_solarsystems.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_eve_names.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_eve_sta_stations.txt.gz

load

# THESE ARE UPDATED ONCE A DAY AT DOWNTIME.
wget -P tmp http://eve-marketdata.com/developers/mysql_eve_inv_types.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_items_buying.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_items_selling.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_station_rank.txt.gz
#wget -P tmp http://eve-marketdata.com/developers/mysql_items_history.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_region_type_updates.txt.gz
wget -P tmp http://eve-marketdata.com/developers/mysql_region_type_hist_updates.txt.gz

load

rmdir tmp