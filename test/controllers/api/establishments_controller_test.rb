require 'test_helper'

class Api::EstablishmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_establishments_index_url
    assert_response :success
  end

  test "should get show" do
    get api_establishments_show_url
    assert_response :success
  end

end
