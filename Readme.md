# Flow
## Client Side
#### Javascript client
  URL: http://foobar.com/test.html?foo=bar&xyz=5#ff
  
  Initalize analytic
  
    PR.analytic.init({
      appId: "savannah",
      apiUrl: "http://localhost:3007/api/v1/events",
      userId: <userid or null>
    })
    
    properties = {
     object_class: "course"
     object_id: <some_id>
     ...
    }
    
    PR.analytic.track(<event_name>,properties)
    PR.analytic.trackPageView(properties)

  It will post following AJAX Request
  
    POST "/api/v1/events" 
  
      {
        event_name: "<event name>",
        context: {
          path: "http://foobar.com/test.html",
          referrer: "",
          search: "?foo=bar&xyz=5",
          title: "Test Analytic",
          url: http://foobar.com/test.html?foo=bar&xyz=5#ff"
        },
        browser: {
          locale: "en-US",
          user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"
        },
        session_id: "<UUID> like 0eb9f36f-ef19-4487-be9f-67696aa9db52",
        user_id: <userid>,
      }

# Collector
### Sinatra collector        
 - Configure rabbitmq server
 - Replace credential to prismatic/collector/prismatic_collector.rb
 
        bundle install
        rackup config.ru -p 3007

### Go collector
Get Event from client via post request and push raw event to rabbitmq for further Process    

* Configure rabbitmq server
* Replace credential to prismatic/collector/prismatic_collector.go
* Install dependency
 
        go get github.com/gin-gonic/gin
        go get github.com/streadway/amqp
        go get github.com/itsjamie/gin-cors
        go run prismatic/collector/prismatic_collector.go
  * Local Run
    cd $GO_ROOT/src/github.com/amardaxini/
    copy prismatic_collector
    PORT=8081 AMQP_URL=amqp://guest:guest@localhost:5672/ go run prismatic_collector.go
  * Heroku URL
    http://prismatic-collector.herokuapp.com/api/v1/events
               

# Enrichment (TODO)
* Install fregeoip service 
  * https://github.com/fiorix/freegeoip
  * Heroku url: https://prismatic-geoip.herokuapp.com/json/<ip-address>
  * Move service to docker or used paid plan and configure for redis service instead of tmp file
* Write worker for get operating system and broweser detail from user agent
  * We can use sneaker for background jobs
  * https://github.com/fnando/browser gem can be usefull for getting browser information from useragent
* write worker for get country,state,city info from geoip service
  * We can call freegeoip service to get user country information
* After processing push clean data to elastic search and postgres schema

