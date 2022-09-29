migrateup:
	migrate -path db/migration -database "postgresql://admin:Passw0rd@localhost:5432/simplebank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://admin:Passw0rd@localhost:5432/simplebank?sslmode=disable" -verbose down

sqlc:
	sqlc generate
test: 
	go test -v -cover ./...

server:
	go run main.go 	

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/bandrade/simplebank/db/sqlc Store

proto:
	rm -rf doc/statik/statik.go
	rm -rf pb/*.go
	rm -rf doc/swagger/*.json
	protoc --openapiv2_out=doc/swagger --openapiv2_opt=allow_merge=true,merge_file_name=simple_bank --proto_path=proto  --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative --grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative\
    proto/*.proto
	statik -src=./doc/swagger -dest=./doc

evans:
	 evans --host localhost --port 5100 -r repl    

.PHONY: migrateup migratedown sqlc server mock proto