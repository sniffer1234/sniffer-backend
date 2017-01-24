require 'test_helper'

class Admin::EstablishmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_establishments_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_establishments_create_url
    assert_response :success
  end

end
