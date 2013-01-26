require 'test_helper'

class Me::PostsControllerTest < ActionController::TestCase
  setup do
    @me_post = me_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:me_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create me_post" do
    assert_difference('Me::Post.count') do
      post :create, me_post: {  }
    end

    assert_redirected_to me_post_path(assigns(:me_post))
  end

  test "should show me_post" do
    get :show, id: @me_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @me_post
    assert_response :success
  end

  test "should update me_post" do
    put :update, id: @me_post, me_post: {  }
    assert_redirected_to me_post_path(assigns(:me_post))
  end

  test "should destroy me_post" do
    assert_difference('Me::Post.count', -1) do
      delete :destroy, id: @me_post
    end

    assert_redirected_to me_posts_path
  end
end
