package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/itsjamie/gin-cors"
	"github.com/streadway/amqp"
	"io/ioutil"
	"log"
	"os"
	"time"
)

type RbmqConfig struct {
	q       amqp.Queue
	ch      *amqp.Channel
	conn    *amqp.Connection
	rbmqErr error
}
type EventJson struct {
	UserId        string                 `json:"user_id"`
	ContextInfo   map[string]interface{} `json:"context_info"`
	Browser       map[string]interface{} `json:"browser"`
	SessionId     string                 `json:"session_id" binding:"required"`
	Properties    map[string]interface{} `json:"properties"`
	ClientIp      string                 `json:"client_ip"`
	ScreenWidth   int                    `json:"screen_width"`
	ScreenHeight  int                    `json:"screen_height"`
	EventName     string                 `json:"event_name" binding:"required"`
	TrackerName   string                 `json:"tracker_name"  binding:"required"`
	EventTime     string                 `json:"event_time"`
	CollectorTime time.Time              `json:"collector_time"`
}

func initRabbitMq() *RbmqConfig {

	config := &RbmqConfig{}
	config.conn, config.rbmqErr = amqp.Dial(os.Getenv("AMQP_URL"))
	failOnError(config.rbmqErr, "Failed to connect to RabbitMQ")
	config.ch, config.rbmqErr = config.conn.Channel()
	failOnError(config.rbmqErr, "Failed to open a channel")
	config.q, config.rbmqErr = config.ch.QueueDeclare(
		"event_queue",
		true,  // durable
		false, // delete when unused
		false, // exclusive
		false, // no-wait
		nil,   // arguments
	)
	failOnError(config.rbmqErr, "Failed to declare a queue")
	return config
}

var rbconfig = initRabbitMq()

func main() {
	fmt.Printf("Start")
	router := gin.Default()
	router.Use(cors.Middleware(cors.Config{
		Origins:        "*",
		Methods:        "GET, PUT, POST",
		RequestHeaders: "Origin, Authorization, Content-Type",
		ExposedHeaders: "",
		// MaxAge: 50 * time.Second,
		Credentials:     true,
		ValidateHeaders: false,
	}))
	// router.Use(InitRabbitMQ())

	v1 := router.Group("/api/v1")
	{
		v1.POST("/events", eventEndpoint)
	}
	port := os.Getenv("PORT")
	router.Run(":" + port) // listen and server on 0.0.0.0:8080
}

func eventEndpoint(c *gin.Context) {
	var bodyBytes []byte

	if c.Request.Body != nil {
		bodyBytes, _ = ioutil.ReadAll(c.Request.Body)
	}
	// // Restore the io.ReadCloser to its original state
	c.Request.Body = ioutil.NopCloser(bytes.NewBuffer(bodyBytes))
	// // Use the content
	// var json EventJson

	// bodyString := string(bodyBytes)
	// fmt.Printf("%s", bodyString)
	var event EventJson
	json.Unmarshal(bodyBytes, &event)
	event.ClientIp = c.ClientIP()
	event.CollectorTime = time.Now().UTC()
	rawEvent, _ := json.Marshal(event)
	fmt.Printf("%s", rawEvent)
	err := rbconfig.ch.Publish(
		"",              // exchange
		rbconfig.q.Name, // routing key
		false,           // mandatory
		false,           // immediate
		amqp.Publishing{
			DeliveryMode: amqp.Persistent,
			Headers:      amqp.Table{},
			ContentType:  "application/json",
			Body:         (rawEvent),
		})
	failOnError(err, "Failed to publish a message")
	if err != nil {
		c.JSON(500, gin.H{
			"status": "fail",
		})
	} else {
		c.JSON(200, gin.H{
			"status": "success",
		})
	}
}

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
		// panic(fmt.Sprintf("%s: %s", msg, err))
	}
}
