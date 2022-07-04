require "test_helper"

class Public::AcquaintancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_acquaintances_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_acquaintances_edit_url
    assert_response :success
  end
end
