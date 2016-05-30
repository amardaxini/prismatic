class BrowserEnrichmentService
  attr_reader :browser,:platform,:device,:client
  def initialize(user_agent,locale="en-us")
    @user_agent = user_agent
    @client =  Browser.new(@user_agent, accept_language: locale)
  end
  def perform
    @browser = @client.to_s
    @device = @client.device.name
    @platform = @client.platform.name
  end
end