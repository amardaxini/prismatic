# Flow
  URL: http://foobar.com/test.html?foo=bar&xyz=5#ff
  properties = {
    object_class: "course"
    object_id: <some_id>
    ...
  }
  PR.analytic.track(<event_name>,properties)

  POST "/api/v1/events" 
  {
    event_name: ""
    context: {
      path: "http://foobar.com/test.html"
      referrer: ""
      search: "?foo=bar&xyz=5"
      title: "Test Analytic"
      url: http://foobar.com/test.html?foo=bar&xyz=5#ff"
    }
    browser: {
      locale: "en-US"
      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"
    }
    session_id: "<UUID> like 0eb9f36f-ef19-4487-be9f-67696aa9db52"
    user_id: <userid>
  }



# Start Server
rackup config.ru -p 3007



