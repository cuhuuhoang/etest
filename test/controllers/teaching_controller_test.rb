require 'test_helper'

class TeachingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get teach" do
    get :teach
    assert_response :success
  end

  test "should get study" do
    get :study
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
