require "test_helper"

class SettlementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get settlements_new_url
    assert_response :success
  end

  test "should get create" do
    get settlements_create_url
    assert_response :success
  end
end
