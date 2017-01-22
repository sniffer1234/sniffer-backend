require 'test_helper'

class Api::LiveControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_live_index_url
    assert_response :success
  end

end
