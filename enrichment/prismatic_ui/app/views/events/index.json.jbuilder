json.array!(@events) do |event|
  json.extract! event, :id, :name, :object_id, :object_class, :user_id, :session_id, :page_url, :page_path, :page_referrer, :page_search, :user_agent, :ip, :country_code, :country_name, :region_code, :region_name, :city, :time_zone, :latitude, :longitude, :zip_code, :platform, :device, :browser, :device_id, :event_time, :action_class, :action_type
  json.url event_url(event, format: :json)
end
