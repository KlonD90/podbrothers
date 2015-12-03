require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get podcasts" do
    get :podcasts
    assert_response :success
  end

  test "should get episodes" do
    get :episodes
    assert_response :success
  end

end
