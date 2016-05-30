require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { action_class: @event.action_class, action_type: @event.action_type, browser: @event.browser, city: @event.city, country_code: @event.country_code, country_name: @event.country_name, device: @event.device, device_id: @event.device_id, event_time: @event.event_time, ip: @event.ip, latitude: @event.latitude, longitude: @event.longitude, name: @event.name, object_class: @event.object_class, object_id: @event.object_id, page_path: @event.page_path, page_referrer: @event.page_referrer, page_search: @event.page_search, page_url: @event.page_url, platform: @event.platform, region_code: @event.region_code, region_name: @event.region_name, session_id: @event.session_id, time_zone: @event.time_zone, user_agent: @event.user_agent, user_id: @event.user_id, zip_code: @event.zip_code }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { action_class: @event.action_class, action_type: @event.action_type, browser: @event.browser, city: @event.city, country_code: @event.country_code, country_name: @event.country_name, device: @event.device, device_id: @event.device_id, event_time: @event.event_time, ip: @event.ip, latitude: @event.latitude, longitude: @event.longitude, name: @event.name, object_class: @event.object_class, object_id: @event.object_id, page_path: @event.page_path, page_referrer: @event.page_referrer, page_search: @event.page_search, page_url: @event.page_url, platform: @event.platform, region_code: @event.region_code, region_name: @event.region_name, session_id: @event.session_id, time_zone: @event.time_zone, user_agent: @event.user_agent, user_id: @event.user_id, zip_code: @event.zip_code }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
