class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :object_id
      t.string :object_class
      t.string :user_id
      t.string :session_id
      t.text :page_url
      t.text :page_path
      t.string :page_referrer
      t.text :page_search
      t.string :user_agent
      t.string :ip
      t.string :country_code
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :time_zone
      t.float :latitude
      t.float :longitude
      t.string :zip_code
      t.string :platform
      t.string :device
      t.string :browser
      t.string :device_id
      t.datetime :event_time
      t.datetime :collector_event_time
      t.string :tracker_id 
      t.string :action_class
      t.string :action_type
      t.json :properties
      t.string :app_id
      t.string :app_name

      t.timestamps null: false
    end
  end
end
