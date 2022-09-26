migrateup:
	migrate -path db/migration -database "postgresql://admin:Passw0rd@localhost:5432/simplebank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://admin:Passw0rd@localhost:5432/simplebank?sslmode=disable" -verbose down

sqlc:
	sqlc generate
test: 
	go test -v -cover ./...
.PHONY: migrateup migratedown sqlc