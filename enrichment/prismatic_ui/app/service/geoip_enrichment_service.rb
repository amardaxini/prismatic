class GeoipEnrichmentService
  attr_reader :ip_address,:country_code,:country_name,:region_code,:region_name,:city
  attr_reader :time_zone,:latitude,:longitude,:zip_code
  
  def initialize(ip_address)
    @ip_address = ip_address
 
  end
  def perform
    
    http = Excon.get("#{Settings.geo_ip_url}/#{@ip_address}")
    if http.status.to_i == 200
      response = JSON.parse(http.body)
      @country_code = response["country_code"]
      @country_name = response["country_name"]
      @region_code = response["region_code"]
      @city = response["city"]
      @time_zone = response["time_zone"]
      @latitude = response["latitude"]
      @longitude = response["longitude"]
      @zip_code = response["zip_code"]
    end
  end
end