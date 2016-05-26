require 'bundler/setup'
require 'sneakers'
require 'sneakers/runner'
opts = {
  :amqp => 'amqp://guest:guest@localhost:5672',
} 

Sneakers.configure(opts)

class EnrichmentWorker
  include Sneakers::Worker
  from_queue 'event_queue'

  def work(msg)
    logger.info "hello #{msg}"
      
    ack!
  end
end

