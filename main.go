package main

import (
	"database/sql"
	"log"

	"github.com/bandrade/simplebank/api"
	db "github.com/bandrade/simplebank/db/sqlc"
	_ "github.com/lib/pq"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://admin:Passw0rd@localhost:5432/simplebank?sslmode=disable"
	serverAddress = "0.0.0.0:5000"
)

func main() {
	var err error
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)

	}
	store := db.NewStore(conn)
	server := api.NewServer(store)
	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)

	}
}
