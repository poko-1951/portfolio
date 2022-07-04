require "test_helper"

class Public::TopicControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_topic_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_topic_edit_url
    assert_response :success
  end
end
