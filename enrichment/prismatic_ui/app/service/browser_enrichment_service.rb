class BrowserEnrichmentService
  attr_reader :browser,:platform,:devise
  def initialize(user_agent,locale="en-us")
    @user_agent = user_agent
    @client =  Browser.new(@user_agent, accept_language: locale)
  end
  def perform
    @browser = @client.to_s
    @devise = @client.device.name
    @browser = @client.platform.name
  end
end