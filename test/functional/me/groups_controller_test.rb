require 'test_helper'

class Me::GroupsControllerTest < ActionController::TestCase
  setup do
    @me_group = me_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:me_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create me_group" do
    assert_difference('Me::Group.count') do
      post :create, me_group: {  }
    end

    assert_redirected_to me_group_path(assigns(:me_group))
  end

  test "should show me_group" do
    get :show, id: @me_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @me_group
    assert_response :success
  end

  test "should update me_group" do
    put :update, id: @me_group, me_group: {  }
    assert_redirected_to me_group_path(assigns(:me_group))
  end

  test "should destroy me_group" do
    assert_difference('Me::Group.count', -1) do
      delete :destroy, id: @me_group
    end

    assert_redirected_to me_groups_path
  end
end
