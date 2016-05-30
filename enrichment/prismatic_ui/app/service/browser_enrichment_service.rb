class BrowserEnrichmentService
  attr_reader :browser,:platform,:device,:client
  def initialize(user_agent,locale="en-us")
    @user_agent = user_agent
    @client =  DeviceDetector.new(@user_agent)
  end
  def perform
    @browser = @client.name
    @device = @client.device.device_type
    @platform = @client.os_name
  end
end