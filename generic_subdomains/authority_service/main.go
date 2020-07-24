package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
    router := gin.Default()
    router.LoadHTMLGlob("templates/*.html")

    router.GET("/", func(ctx *gin.Context){
        ctx.JSON(http.StatusOK, gin.H{"message": "ok"})
    })

    router.Run()
}
