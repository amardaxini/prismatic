class GeoipEnrichmentService
  attr_reader :ip_address,:country_code,:country_name,:region_code,:region_name,:city
  attr_reader :time_zone,:latitude,:longitude,:zip_code
  def initialize(ip_address)
    @ip_address = ip_address
 
  end
  def perform
  
  end
end