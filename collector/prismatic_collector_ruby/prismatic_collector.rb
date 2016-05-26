require 'bundler'
Bundler.require
$conn = Bunny.new
$conn.start
ch   = $conn.create_channel
$queue = ch.queue("event_queue_ruby")
post '/api/v1/events' do
  content_type :json
  cross_origin :allow_origin=>:any
  message = JSON.parse(request.body.read)
  message["ip"] = request.ip
  puts @env['REMOTE_ADDR']
  $queue.publish(message.to_json, :persistent => true)
  {:status=>"success"}.to_json
end

get '/api/v1/event' do
  content_type :json

  # binding.pry
  {:status=>"success"}.to_json
end
