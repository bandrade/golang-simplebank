package gapi

import (
	db "github.com/bandrade/simplebank/db/sqlc"
	"github.com/bandrade/simplebank/pb"
)

func convertUser(user db.User) *pb.User {
	return &pb.User{
		Username: user.Username,
		FullName: user.FullName,
		Email:    user.Email,
	}
}
