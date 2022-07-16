require "test_helper"

class Public::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_events_new_url
    assert_response :success
  end

  test "should get index" do
    get public_events_index_url
    assert_response :success
  end
end
