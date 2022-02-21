package main

import (
	"go-woofie-api/connections/miniostorage"
	"go-woofie-api/database"
	"go-woofie-api/lib/middlewares"
	"os"

	"go-woofie-api/api"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	// load .env environment variables
	err := godotenv.Load()
	if err != nil {
		panic(err)
	}

	// initializes database
	db, _ := database.Initialize()

	// initializes minio client
	minioClient, _ := miniostorage.Initialize()

	port := os.Getenv("PORT")

	gin.SetMode(gin.ReleaseMode)
	app := gin.Default() // create gin app

	app.Use(database.Inject(db))
	app.Use(miniostorage.Inject(minioClient))
	app.Use(middlewares.JWTMiddleware())

	api.ApplyRoutes(app) // apply api router
	app.Run(":" + port)  // listen to given port
}
