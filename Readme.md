# Flow
## Client Side
#### Javascript client
  URL: http://foobar.com/test.html?foo=bar&xyz=5#ff
  
  Initalize analytic
  
    PR.analytic.init({
      app_key: "somekey",
      apiUrl: "http://localhost:3007/api/v1/events",
      userId: <userid or null>
    })
    
    properties = {
     object_class: "course"
     object_id: <some_id>
     ...
    }
    
    PR.analytic.track(<event_name>,properties)

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




# Enrichment (TODO)
* Write worker for get operating system and broweser detail from user agent
* write worker for get country,state,city info from geoip service

