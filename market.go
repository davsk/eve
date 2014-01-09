package main

import (
	"dasa.cc/dae/context"
	"dasa.cc/dae/datastore"
	"dasa.cc/dae/handler"
	"dasa.cc/dae/render"
	"dasa.cc/dae/user"
	"labix.org/v2/mgo/bson"
	"net/http"
	"database/sql"
	_ "github.com/lib/pq"
	"log"
)

func GetTableNames() (tableNames []string) {

	db, err := sql.Open("postgres", "user=goeve password=goeve dbname=eve sslmode=disable")
	if err != nil {
		log.Fatal("sql.Open failed:", err)
	}
	defer db.Close()

	rows, err := db.Query("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
	if err != nil {
		log.Fatal("db.Query failed:", err)
	}
	defer rows.Close()

	for rows.Next() {
		var tableName string
		rows.Scan(&tableName)
		tableNames = append(tableNames, tableName)
	}

	if err := rows.Err(); err != nil {
		log.Fatal("rows.Err:", err)
	}

	return tableNames
}

func GetColumnNames(tableName string) (columnNames []string) {

	db, err := sql.Open("postgres", "user=goeve password=goeve dbname=eve sslmode=disable")
	if err != nil {
		log.Fatal("sql.Open failed:", err)
	}
	defer db.Close()

	rows, err := db.Query("SELECT column_name FROM information_schema.columns WHERE table_name = '"+tableName+"'")
	if err != nil {
		log.Fatal("db.Query failed:", err)
	}
	defer rows.Close()

	for rows.Next() {
		var columnName string
		rows.Scan(&columnName)
		columnNames = append(columnNames, columnName)
	}

	if err := rows.Err(); err != nil {
		log.Fatal("rows.Err:", err)
	}

	return columnNames
}

func GetGroupNames() (groupNames []string) {
	db, err := sql.Open("postgres", "user=goeve password=goeve dbname=eve sslmode=disable")
	if err != nil {
		log.Fatal("sql.Open failed:", err)
	}
	defer db.Close()

	rows, err := db.Query("select group_name from eve_inv_types limit 10;")
	if err != nil {
		log.Fatal("db.Query failed:", err)
	}
	defer rows.Close()

	for rows.Next() {
		var groupName string
		rows.Scan(&groupName)
		groupNames = append(groupNames, groupName)
	}

	if err := rows.Err(); err != nil {
		log.Fatal("rows.Err:", err)
	}

	return groupNames
}

func market(w http.ResponseWriter, r *http.Request) *handler.Error {
	db := datastore.New()
	defer db.Close()

	c := context.New(r)
	u := user.Current(c, db)

	tables := make(map[string][]string)

	for _, name := range GetTableNames() {
		log.Println(name)
		tables[name] = GetColumnNames(name)
	}

	render.Auto(w, r, bson.M{"User": u, "Tables": tables})

	return nil
}

func init() {
	http.Handle("/market/", handler.New(handler.Auth, market))

}
