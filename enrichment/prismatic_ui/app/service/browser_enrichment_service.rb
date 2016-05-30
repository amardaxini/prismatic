class BrowserEnrichmentService
  attr_reader :browser,:platform,:device,:client,:os_name
  def initialize(user_agent,locale="en-us")
    @user_agent = user_agent
    @client =  DeviceDetector.new(@user_agent)
  end
  def perform
    @browser = @client.name
    @device = @client.device.device_type
    @os_name = @client.os_name
  end
end