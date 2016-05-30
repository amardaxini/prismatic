class EventEbrichWorker
  include Sneakers::Worker
  from_queue 'event_queue'

  def work(msg)
    logger.info "hello #{msg}"
    ack!
  end
end
