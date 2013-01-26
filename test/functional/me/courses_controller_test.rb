require 'test_helper'

class Me::CoursesControllerTest < ActionController::TestCase
  setup do
    @me_course = me_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:me_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create me_course" do
    assert_difference('Me::Course.count') do
      post :create, me_course: {  }
    end

    assert_redirected_to me_course_path(assigns(:me_course))
  end

  test "should show me_course" do
    get :show, id: @me_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @me_course
    assert_response :success
  end

  test "should update me_course" do
    put :update, id: @me_course, me_course: {  }
    assert_redirected_to me_course_path(assigns(:me_course))
  end

  test "should destroy me_course" do
    assert_difference('Me::Course.count', -1) do
      delete :destroy, id: @me_course
    end

    assert_redirected_to me_courses_path
  end
end
