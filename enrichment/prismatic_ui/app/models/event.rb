class Event < ActiveRecord::Base
  searchkick callbacks: :async
  def search_data
    as_json
  end
end
