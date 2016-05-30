class EventEnrichWorker
  include Sneakers::Worker
  from_queue 'event_queue'

  def work(msg)
    logger.info "hello #{msg}"
    binding.pry
    if msg
      event_msg = JSON.parse(msg)
      event_params = {
        "user_id" => event_msg["user_id"],
        "event_name"=>event_msg["event_name"],
        "tracker_name"=>event_msg["tracker_name"],
        "session_id"=>event_msg["session_id"],
        "object_id"=>event_msg["properties"] && event_msg["properties"]["object_id"],
        "object_class"=>event_msg["properties"] && event_msg["properties"]["object_class"],
        "action_class"=>event_msg["properties"] && event_msg["properties"]["action_class"],
        "action_type"=>event_msg["properties"] && event_msg["properties"]["action_type"],
        "app_id"=>event_msg["properties"] && event_msg["properties"]["app_id"],
        "app_name"=>event_msg["properties"] && event_msg["properties"]["app_name"],
        "page_url"=>event_msg["context_info"] && event_msg["context_info"]["url"],
        "page_path"=>event_msg["context_info"] && event_msg["context_info"]["url"],
        "page_referrer"=>event_msg["context_info"] && event_msg["context_info"]["referrer"],
        "page_search"=>event_msg["context_info"] && event_msg["context_info"]["search"],
        "user_agent"=>event_msg["browser"],
        "screen_width"=>event_msg["screen_width"],
        "screen_width"=>event_msg["screen_height"],
        "event_time"=>event_msg["event_time"],
        "collector_event_time"=>event_msg["collector_time"]
      }  
      if event_msg["browser"]
        browser = BrowserEnrichmentService.new(event_msg["browser"]["user_agent"])
        browser.perform
        event_params["browser"] = browser.browser
        event_params["device_name"] = browser.device_nmae
        event_params["device_type"] = browser.device_type
        event_params["device_type"] = browser.device_type
        event_params["os_name"] = browser.os_name
      end  

      Event.create
      ack!
    else
      ack!
    end  
    
    
  end
end
