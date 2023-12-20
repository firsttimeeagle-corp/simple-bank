package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type pingResponse struct {
	Version string `json:"version"`
}

func (server *Server) ping(ctx *gin.Context) {
	rsp := pingResponse{
		Version: server.config.AppVersion,
	}

	ctx.JSON(http.StatusOK, rsp)
}
