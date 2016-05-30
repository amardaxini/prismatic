class BrowserEnrichmentService
  attr_reader :browser,:platform,:device_type,:client,:os_name,:device_name
  def initialize(user_agent,locale="en-us")
    @user_agent = user_agent
    @client =  DeviceDetector.new(@user_agent)
  end
  def perform
    @browser = @client.name
    @device_type = @client.device_type
    @device_name = @client.device_name
    @os_name = @client.os_name
  end
end