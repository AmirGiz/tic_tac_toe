require "test_helper"

class GridControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get grid_index_url
    assert_response :success
  end
end
