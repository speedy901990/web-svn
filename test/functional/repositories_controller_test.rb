require 'test_helper'

class RepositoriesControllerTest < ActionController::TestCase
  test "should get create_repo" do
    get :create_repo
    assert_response :success
  end

end
