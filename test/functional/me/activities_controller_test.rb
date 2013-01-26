require 'test_helper'

class Me::ActivitiesControllerTest < ActionController::TestCase
  setup do
    @me_activity = me_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:me_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create me_activity" do
    assert_difference('Me::Activity.count') do
      post :create, me_activity: {  }
    end

    assert_redirected_to me_activity_path(assigns(:me_activity))
  end

  test "should show me_activity" do
    get :show, id: @me_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @me_activity
    assert_response :success
  end

  test "should update me_activity" do
    put :update, id: @me_activity, me_activity: {  }
    assert_redirected_to me_activity_path(assigns(:me_activity))
  end

  test "should destroy me_activity" do
    assert_difference('Me::Activity.count', -1) do
      delete :destroy, id: @me_activity
    end

    assert_redirected_to me_activities_path
  end
end
