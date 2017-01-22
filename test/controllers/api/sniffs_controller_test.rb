require 'test_helper'

class Api::SniffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_sniffs_index_url
    assert_response :success
  end

end
