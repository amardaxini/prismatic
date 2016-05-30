class EventEnrichWorker
  include Sneakers::Worker
  from_queue 'event_queue'

  def work(msg)
    logger.info "hello #{msg}"
    begin
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
          "user_agent"=>event_msg["browser"] && event_msg["browser"]["user_agent"],
          "screen_width"=>event_msg["screen_width"],
          "screen_height"=>event_msg["screen_height"],
          "event_time"=>event_msg["event_time"],
          "collector_event_time"=>event_msg["collector_time"],
          "ip_address"=>event_msg["client_ip"],
        }  

        if event_msg["browser"]
          browser = BrowserEnrichmentService.new(event_msg["browser"]["user_agent"])
          browser.perform
          event_params["browser"] = browser.browser
          event_params["device_name"] = browser.device_name
          event_params["device_type"] = browser.device_type
          event_params["device_type"] = browser.device_type
          event_params["os_name"] = browser.os_name
        end  

        if event_msg["client_ip"]
          geoip = GeoipEnrichmentService.new(event_msg["client_ip"])
          geoip.perform
          event_params["country_code"] = geoip.country_code
          event_params["country_name"] = geoip.country_name
          event_params["region_code"] = geoip.region_code
          event_params["region_name"] = geoip.region_name
          event_params["city"] = geoip.city
          event_params["time_zone"] = geoip.time_zone
          event_params["latitude"] = geoip.latitude
          event_params["longitude"] = geoip.longitude

        end
        
        if event_msg["properties"]
          event_properties = {}

          event_msg["properties"].each do |key,val|
            unless ["object_class","object_id","action_class","action_id","app_name","app_id"].include?(key)
              event_properties[key] = val
            end
          end
          event_params["properties"] = event_properties
        end

        Event.create(event_params)
      
      end  
    rescue => e
      logger.error "Wokrer faile #{e.message}"
    end  
      ack!
    
  end
end
