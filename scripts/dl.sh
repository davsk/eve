#! /usr/bin/env bash

# crontab -e
# 10 5 * * * /home/david/workspace/src/dasa.cc/eve/scripts/dl.sh daily
# 10 6 1 * * /home/david/workspace/src/dasa.cc/eve/scripts/dl.sh monthly


function load {
	gzip -d tmp/*.gz
	echo "Working!"
	ls tmp/*.txt | awk '{print "./convert.awk "$1" > "$1".new; mv "$1".new "$1";psql eve -f "$1}' | sh

	# debug
	#ls tmp/*.txt | awk '{print "./convert.sh " $1 " > " $1 ".new"}' | sh

	rm tmp/*.txt
}

mkdir -p tmp
su - postgres -c "psql --dbname=eve --file=../sql/dropPublicViews.sql"

case "$1" in
	"")
		echo "Usage: ${0##*/} daily | monthly | static"
		;;
	"static")
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
		;;
	"daily")
		# THESE ARE UPDATED ONCE A DAY AT DOWNTIME.
		wget -P tmp http://eve-marketdata.com/developers/mysql_eve_inv_types.txt.gz
		wget -P tmp http://eve-marketdata.com/developers/mysql_items_buying.txt.gz
		wget -P tmp http://eve-marketdata.com/developers/mysql_items_selling.txt.gz
		wget -P tmp http://eve-marketdata.com/developers/mysql_region_type_updates.txt.gz
		wget -P tmp http://eve-marketdata.com/developers/mysql_region_type_hist_updates.txt.gz

		load
		;;
	"monthly")
		# updated daily but only needed monthly
		wget -P tmp http://eve-marketdata.com/developers/mysql_station_rank.txt.gz
		#wget -P tmp http://eve-marketdata.com/developers/mysql_items_history_theforge_90.txt.gz
		load

		# large files
		#wget -P tmp http://eve-marketdata.com/developers/mysql_items_history.txt.gz
		wget -P tmp http://eve-marketdata.com/developers/mysql_items_history_30.txt.gz
		gzip -d tmp/*.gz
		ls tmp/*.txt | awk '{print "./convert.awk "$1" > "$1".new; mv "$1".new "$1"; ./psql-split.sh "$1}'
		rm tmp/*.txt
		;;
esac

rmdir tmp
su - postgres -c "psql --dbname=eve --file=../sql/publicViews.sql"
