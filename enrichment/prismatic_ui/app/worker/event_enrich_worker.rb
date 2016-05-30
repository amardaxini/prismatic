class EventEnrichWorker
  include Sneakers::Worker
  from_queue 'event_queue'

  def work(msg)
    logger.info "hello #{msg}"
    binding.pry
    if msg
      event_msg = JSON.parse(msg)
      if msg["browser"]
        browser = BrowserEnrichmentService.new(event_msg["browser"]["user_agent"])
        
      end  

      Event.create
      ack!
    else
      ack!
    end  
    
    
  end
end
